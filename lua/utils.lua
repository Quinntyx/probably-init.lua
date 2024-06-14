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

return u
