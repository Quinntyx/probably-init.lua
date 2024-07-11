require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clangd",
		"html",
		"pyright",
		"cssls",
	},
	automatic_installation = true
})
