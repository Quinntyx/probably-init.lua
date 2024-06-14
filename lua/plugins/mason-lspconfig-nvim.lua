require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clangd",
		"html",
		"ltex",
		"pyright",
		"cssls",
	},
	automatic_installation = true
})
