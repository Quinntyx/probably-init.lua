-- Minimal helix-style global statusline:
--   ` NOR  path/to/file [+] ` .............. ` ✗2 ⚠1  1 sel  12:4 `
-- Mode segment colors match helix everforest_light (green NOR / slate INS / blue SEL).

local M = {}

M.modes = {
    ["n"] = { "NOR", "User1" },
    ["no"] = { "NOR", "User1" },
    ["i"] = { "INS", "User2" },
    ["v"] = { "SEL", "User3" },
    ["V"] = { "SEL", "User3" },
    ["\22"] = { "SEL", "User3" }, -- ^V (blockwise)
    ["c"] = { "CMD", "User4" },
    ["R"] = { "REP", "User4" },
    ["t"] = { "TER", "User4" },
}

local function diagnostics()
    local errors, warnings = 0, 0
    for _, d in ipairs(vim.diagnostic.get(0)) do
        if d.severity == vim.diagnostic.severity.ERROR then
            errors = errors + 1
        elseif d.severity == vim.diagnostic.severity.WARN then
            warnings = warnings + 1
        end
    end
    local out = {}
    if errors > 0 then table.insert(out, "✗" .. errors) end
    if warnings > 0 then table.insert(out, "⚠" .. warnings) end
    if #out > 0 then
        return table.concat(out, " ") .. "  "
    end
    return ""
end

function M.draw()
    local mode = vim.api.nvim_get_mode().mode
    local m = M.modes[mode] or M.modes[mode:sub(1, 1)] or M.modes["n"]

    local name = vim.api.nvim_buf_get_name(0)
    local fname = name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "[scratch]"
    fname = fname:gsub("%%", "%%%%")

    return ("%%#%s# %s %%#StatusLine# %s %%m %%=%s1 sel  %%l:%%c ")
        :format(m[2], m[1], fname, diagnostics())
end

function M.setup()
    vim.o.statusline = "%{%v:lua.require('statusline').draw()%}"
end

return M
