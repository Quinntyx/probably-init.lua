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
		vim.cmd([[
		set foldcolumn=0
		]])
    end
})

vim.cmd([[
Neotree show
]])
