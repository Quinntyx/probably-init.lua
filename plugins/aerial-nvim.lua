require("aerial").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
	end,
	layout = {
		min_width = { 0.2, 16 },
		resize_to_content = false,
	},
	attach_mode = "window",
	manage_folds = "true",
	link_folds_to_tree = "true",
	link_tree_to_folds = "true",
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle right<CR>")
