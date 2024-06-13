local function M()
	require('nvim-navic').setup({
		lsp = {
			auto_attach = false,
		},
	})
end

return M
