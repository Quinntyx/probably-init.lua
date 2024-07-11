local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end
end

local lspc = require('lspconfig')

vim.diagnostic.config({virtual_text = false})

lspc.clangd.setup({
    on_attach = on_attach
})

-- credit: heather7283 for lua lsp config
lspc.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty=false,
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                }
            }
        }
    },
    on_attach = on_attach
})

lspc.rust_analyzer.setup({
    on_attach = on_attach
})

lspc.html.setup({
    on_attach = on_attach
})

lspc.pyright.setup({
    on_attach = on_attach
})

lspc.cssls.setup({
    on_attach = on_attach
})
