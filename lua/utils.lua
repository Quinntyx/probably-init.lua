local u = {}

local REQUIRED_KNOBS = { "lsp", "completion", "git", "treesitter", "colorscheme", "whichkey" }

function u.config_path()
    return vim.fn.stdpath("config")
end

function u.lua_path()
    return u.config_path() .. "/lua"
end

function u.module_available(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == "function" then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end

-- knobs.lua is machine-local (gitignored). Regenerated from knobs.default.lua
-- when missing or malformed (key set drifts between config versions).
function u.knobs()
    local ok, knobs = pcall(require, "knobs")

    local valid = ok and type(knobs) == "table"
    if valid then
        for _, key in ipairs(REQUIRED_KNOBS) do
            if type(knobs[key]) ~= "table" or knobs[key].enabled == nil then
                valid = false
                break
            end
        end
    end

    if not valid then
        local defaults = io.open(u.lua_path() .. "/knobs.default.lua", "r")
        local file = io.open(u.lua_path() .. "/knobs.lua", "w")
        if not defaults or not file then
            vim.notify("failed to (re)generate knobs.lua", vim.log.levels.ERROR)
            return knobs or {}
        end
        file:write(defaults:read("*a"))
        file:close()
        defaults:close()
        package.loaded["knobs"] = nil
        ok, knobs = pcall(require, "knobs")
        vim.notify("knobs.lua regenerated from knobs.default.lua")
    end

    return knobs
end

function u.set_theme(theme)
    local knobs = u.knobs()
    if knobs.colorscheme and knobs.colorscheme.enabled == false then
        return
    end
    vim.cmd("colorscheme " .. theme)
end

return u
