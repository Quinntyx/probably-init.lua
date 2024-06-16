-- vim.opt.foldcolumn = 0
--

local function set()
	vim.notify("running callback")
	vim.opt.foldcolumn = '0'
	require('ufo').detach()
end

vim.defer_fn(set, 15)

