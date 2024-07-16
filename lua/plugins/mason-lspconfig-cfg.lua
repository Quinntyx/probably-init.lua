require('mason-lspconfig').setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clangd",
		"html",
		"pyright",
		"cssls",
        "slint_lsp",
	},
	automatic_installation = true
})
