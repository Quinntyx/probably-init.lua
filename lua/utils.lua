local u = {}

function u.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ', '
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
			vim.notify('knobs.default.lua not found', 'error')
			return
		end
		local knobs = io.open(u.lua_path() .. '/knobs.lua', 'w')
		if not knobs then
			vim.notify('failed to create knobs.lua', 'error')
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

-- compatibility for Lua 5.1 / LuaJit 2.1
table.unpack = table.unpack or unpack

return u
