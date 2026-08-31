-- Minuet status segment for the custom helix-style statusline (statusline.lua).
--
-- Shows:
--   * nothing until minuet has actually loaded (ai knob on + InsertEnter)
--   * "AI:Llama.cpp ⠋" (spinner) while a completion request is in flight
--   * "AI ✗" (red) when the llama.cpp server at the configured endpoint is down
--   * "AI" once the server was probed successfully
--
-- Server reachability is probed async with a uv tcp connect, so draw() never
-- blocks. The endpoint (host/port) is taken from the live minuet config once
-- minuet is loaded, falling back to localhost:8012.

local M = {
    processing = false,
    spinner_index = 1,
    n_requests = 1,
    n_finished = 0,
    provider = nil,
    health = nil, -- nil = unknown, true = up, false = down
    host = "127.0.0.1",
    port = 8012,
    endpoint_parsed = false,
}

local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local function refresh_endpoint()
    if M.endpoint_parsed or not package.loaded.minuet then
        return
    end
    local config = require("minuet").config
    local ep = config
        and config.provider_options
        and config.provider_options.openai_fim_compatible
        and config.provider_options.openai_fim_compatible.end_point
    if type(ep) == "string" then
        local host, port = ep:match("https?://([%w%._%-]+):(%d+)")
        if host then
            M.host = host
            M.port = tonumber(port)
        end
    end
    M.endpoint_parsed = true
end

-- newest probe wins: a slow/stale probe must not flip an up-to-date result
local probe_seq = 0

local function connect_to(ip, port, cb)
    local tcp = vim.uv.new_tcp()
    if not tcp then
        cb(false)
        return
    end
    tcp:connect(ip, port, function(err)
        local ok = err == nil
        tcp:close()
        cb(ok)
    end)
end

local function check_health()
    refresh_endpoint()
    probe_seq = probe_seq + 1
    local seq = probe_seq
    local before = M.health
    local function done(ok)
        if seq ~= probe_seq then return end -- stale probe, ignore
        M.health = ok
        if M.health ~= before then
            vim.schedule(function()
                vim.cmd("redrawstatus")
            end)
        end
    end
    -- luv's tcp:connect requires a numeric IP, so resolve hostnames first
    if M.host:match("^%d+%.%d+%.%d+%.%d+$") or M.host:find(":", 1, true) then
        connect_to(M.host, M.port, done)
    else
        vim.uv.getaddrinfo(M.host, nil, { socktype = "stream" }, function(err, res)
            if err or not res or #res == 0 then
                done(false)
                return
            end
            -- prefer IPv4: llama-server (and most local daemons) bind 127.0.0.1
            -- only, while getaddrinfo usually lists ::1 first for 'localhost'
            local v4, rest = {}, {}
            for _, r in ipairs(res) do
                if r.addr:match("^%d+%.%d+%.%d+%.%d+$") then
                    table.insert(v4, r.addr)
                else
                    table.insert(rest, r.addr)
                end
            end
            local addrs = #v4 > 0 and v4 or rest
            -- try each address until one connects
            local i = 1
            local function try()
                if i > #addrs then
                    done(false)
                    return
                end
                local addr = addrs[i]
                i = i + 1
                connect_to(addr, M.port, function(ok)
                    if ok then
                        done(true)
                    else
                        try()
                    end
                end)
            end
            try()
        end)
    end
end

local group = vim.api.nvim_create_augroup("minuet-status", { clear = true })

vim.api.nvim_create_autocmd("User", {
    pattern = "MinuetRequestStartedPre",
    group = group,
    callback = function(ev)
        local d = ev.data or {}
        M.processing = false -- waiting for first chunk
        M.n_requests = d.n_requests or 1
        M.n_finished = 0
        M.provider = d.name
        check_health() -- quick ✗ if the server is down while typing
        vim.cmd("redrawstatus")
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MinuetRequestStarted",
    group = group,
    callback = function()
        M.processing = true
        vim.cmd("redrawstatus")
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MinuetRequestFinished",
    group = group,
    callback = function()
        M.n_finished = M.n_finished + 1
        if M.n_finished >= M.n_requests then
            M.processing = false
            check_health() -- refresh readiness after each burst
        end
        vim.cmd("redrawstatus")
    end,
})

-- animate the spinner only while a request is in flight (redraw is cheap)
local spinner_timer = vim.uv.new_timer()
if spinner_timer then
    spinner_timer:start(200, 200, function()
        if M.processing then
            vim.schedule(function()
                vim.cmd("redrawstatus")
            end)
        end
    end)
end

-- keep server reachability fresh without hammering
local health_timer = vim.uv.new_timer()
if health_timer then
    health_timer:start(10000, 10000, function()
        vim.schedule(check_health)
    end)
end

vim.schedule(check_health)

--- Returns the statusline segment (already %#...#-formatted), or "" if minuet
--- is not loaded / nothing to report.
function M.segment()
    if not package.loaded.minuet then
        return ""
    end

    refresh_endpoint()

    if M.processing then
        M.spinner_index = (M.spinner_index % #spinner_symbols) + 1
        local label = "AI"
        if M.provider then
            label = label .. ":" .. M.provider
        end
        if M.n_requests > 1 then
            label = label .. string.format(" (%d/%d)", M.n_finished + 1, M.n_requests)
        end
        label = label:gsub("%%", "%%%%") -- escape data, not format items
        return ("%%#WarningMsg# %s %s %%#StatusLine#"):format(label, spinner_symbols[M.spinner_index])
    end

    if M.health == false then
        return "%#ErrorMsg#AI ✗ %#StatusLine#"
    end

    if M.health == true then
        return " %#StatusLine#AI"
    end

    return ""
end

return M