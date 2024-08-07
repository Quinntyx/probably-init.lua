local u = {}

function u.map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

function u.get(idx)
    return function(tbl)
        return tbl[idx]
    end
end

function u.set_theme(theme)
    vim.cmd("colorscheme " .. theme)
    dofile(u.lua_path() .. "/setup-final-fixes.lua")
    dofile(u.lua_path() .. "/plugins/visual-whitespace-cfg.lua")
    dofile(u.lua_path() .. "/plugins/window-picker-cfg.lua")
end

function u.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. u.dump(v) .. ', '
        end
        return s .. '}'
    else
        return tostring(o)
    end
end

function u.list_to_table(tbl, fillvalue)
    local output = {}
    for _,key in ipairs(tbl) do
        output[key] = fillvalue
    end
    return output
end

function u.table_to_list(tbl)
    local output = {}
    for v,_ in pairs(tbl) do
        output[#output + 1] = v
    end
    return output
end

function u.module_available(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == 'function' then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end

function u.config_path()
    return vim.fn.stdpath('config')
end

function u.lua_path()
    return u.config_path() .. '/lua'
end

function u.knobs()
    if not u.module_available('knobs') then
        vim.notify('knobs.lua not found, creating new knobs.lua from knobs.default.lua')
        local defaults = io.open(u.lua_path() .. '/knobs.default.lua', 'r')
        if not defaults then
            vim.notify('knobs.default.lua not found', 1)
            return
        end
        local knobs = io.open(u.lua_path() .. '/knobs.lua', 'w')
        if not knobs then
            vim.notify('failed to create knobs.lua', 1)
            return
        end
        knobs:write(
            defaults:read('*a')
        )
        knobs:close()
        defaults:close()
    end
    return require('knobs')
end

u.buf = {}

function u.buf.configure_buffer(opts)
    if opts.fold.enabled then
        vim.opt.foldenable = true
        vim.opt.foldcolumn = tostring(opts.fold.columns)
    else
        require('ufo').detach()
        vim.opt.foldcolumn = '0'
        vim.opt.foldenable = false
    end

    vim.opt.tabstop = opts.tab_stop
    vim.opt.softtabstop = opts.tab_stop
    vim.opt.shiftwidth = opts.tab_stop

    vim.opt.colorcolumn = tostring(opts.line_length)
end

u.ft = {}

function u.ft.get_config(ft_string)
    if not u.module_available('ft.'.. ft_string) then
        vim.notify(ft_string .. ' language configuration not found, populating from default configuration')
        local defaults = io.open(u.lua_path() .. '/ft/default.lua', 'r')
        if not defaults then
            vim.notify('default.lua not found', 1)
            return
        end
        local config = io.open(u.lua_path() .. '/ft/' .. ft_string .. '.lua', 'w')
        if not config then
            vim.notify('failed to create ft/' .. ft_string .. '.lua', 1)
            return
        end
        config:write(
            defaults:read('*a')
        )
        config:close()
        defaults:close()
    end

    return require('ft.' .. ft_string)
end

function u.ft.get_config_fn_by_ft(ft_string)
    local cfg = u.ft.get_config(ft_string)
    return function() u.buf.configure_buffer(cfg) end
end

function u.get_hl(name)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
    if not ok then
        return
    end
    for _, key in pairs({"foreground", "background", "special"}) do
        if hl[key] then
            hl[key] = string.format("#%06x", hl[key])
        end
    end
    return hl

end

-- compatibility for Lua 5.1 / LuaJit 2.1
table.unpack = table.unpack or unpack

return u
