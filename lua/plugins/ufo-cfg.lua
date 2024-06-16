local ufo = require('ufo')

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

local ufo_opts = {}

if require('utils').knobs().lsp then
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	}
	local language_servers = require("lspconfig").util.available_servers()
	for _, ls in ipairs(language_servers) do
		require('lspconfig')[ls].setup({
			capabilities = capabilities
		})
	end
else
	-- set treesitter as provider if lsp is not enabled
	ufo_opts = {
		provider_selector = function(_, _, _) -- we don't care about any of these
			return {'treesitter', 'indent'}
		end
	}
end

ufo.setup(ufo_opts)
