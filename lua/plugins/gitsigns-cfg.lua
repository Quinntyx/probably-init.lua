require('gitsigns').setup({
	signcolumn = true,
	numhl = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
		delay = 0,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
})

vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
