local function M()
	require('navic').setup({
		lsp = {
			auto_attach = false,
		},
	})
end

return M
