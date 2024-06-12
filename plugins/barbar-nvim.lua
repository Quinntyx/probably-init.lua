local M = function()
	require('barbar').setup({
		icons = {
			separator = {
				left = "\u{E0C5}",
				right = "\u{E0C4}",
			},
		},
		sidebar_filetypes = {
			['neo-tree'] = true,
			['aerial'] = true,
		}
	})
end

vim.keymap.set("n", "q", "<cmd>BufferClose<CR>")

return M
