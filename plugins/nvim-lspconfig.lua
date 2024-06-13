local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local M = function()
	local lspc = require('lspconfig')

	lspc.clangd.setup({
		on_attach = on_attach
	})

	lspc.lua_ls.setup({
		on_attach = on_attach
	})
	
	lspc.rust_analyzer.setup({
		on_attach = on_attach
	})

	lspc.html.setup({
		on_attach = on_attach
	})
	
	lspc.ltex.setup({
		on_attach = on_attach
	})

	lspc.pyright.setup({
		on_attach = on_attach
	})

	lspc.cssls.setup({
		on_attach = on_attach
	})
end

return M
