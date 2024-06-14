local utils = require("utils")

local sidepanel_pattern = { 
	["aerial"] = true,
	["neo-tree"] = true,
	["neotree"] = true,
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = utils.table_to_list(sidepanel_pattern),
    callback = function()
		require("ufo").detach()
		vim.opt_local.foldenable = false
		vim.opt_local.foldcolumn = '0'
		vim.cmd([[
		set foldcolumn=0
		]])
    end
})

vim.api.nvim_create_autocmd("BufAdd", {
    callback = function()
		if sidepanel_pattern[vim.bo.filetype] then
			vim.opt_local.foldcolumn = '0'
		end
    end
})

vim.cmd([[
Neotree show
]])
