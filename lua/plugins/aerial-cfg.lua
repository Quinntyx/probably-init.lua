-- currently not in use, Aerial breaks folding hotkeys

local M = function()
	require("aerial").setup({
		on_attach = function(bufnr)
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.cmd([[
			unmap zx
			unmap zm
			nmap zx zo
			nmap zm zc
			]])
		end,
		layout = {
			min_width = { 0.2, 16 },
			resize_to_content = false,
		},
		attach_mode = "window",
		manage_folds = "true",
		link_folds_to_tree = "true",
		link_tree_to_folds = "true",
		keymaps = {
			["zm"] = false,
			["zx"] = false,
		},
	})

end

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle right<CR>")

return M
