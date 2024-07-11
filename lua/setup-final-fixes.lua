local utils = require("utils")

-- i am not sure why this is necessary, but so be it
require('plugins.nvim-lspconfig-cfg')

local sidepanel_pattern = {
	["aerial"] = true,
	["neo-tree"] = true,
	["neotree"] = true,
}

-- vim.api.nvim_create_autocmd("FileType", {
--     -- pattern = utils.table_to_list(sidepanel_pattern),
--     callback = function()
-- 		-- require("ufo").detach()
-- 		-- vim.opt_local.foldenable = false
-- 		vim.cmd([[
-- 		set foldcolumn=8
-- 		]])
--     end
-- })
--

-- vim.call("Neotree", "show")

vim.cmd([[
Neotree
]])
