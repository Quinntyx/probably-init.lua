-- Native LSP setup (no lspconfig, no mason): servers are enabled only when
-- their binary is found in PATH — exactly how helix auto-detects servers.
-- rust-analyzer uses the system binary for parity with the helix setup.

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

local servers = {
    rust_analyzer = {
        cmd = { "rust-analyzer" },  -- system (helix parity)
        root_markers = { "Cargo.toml", "rust-project.json" },
    },
    clangd = {
        cmd = { "clangd" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    },
    jdtls = {
        cmd = { "jdtls" },
        root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
        init_options = {
            extendedClientCapabilities = { classFileContentsSupport = true },
        },
    },
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
    },
    lua_ls = {
        cmd = { "lua-language-server" },
        root_markers = { ".luarc.json", ".git" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
            },
        },
    },
    html = { cmd = { "vscode-html-language-server", "--stdio" } },
    cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
    slint_lsp = { cmd = { "slint-lsp" } },
}

for name, cfg in pairs(servers) do
    if vim.fn.executable(cfg.cmd[1]) == 1 then
        vim.lsp.config[name] = cfg
        vim.lsp.enable(name)
    end
end

-- Diagnostics rendered like helix: inline text, no gutter signs
vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "", suffix = "" },
    underline = true,
    signs = false,
    severity_sort = true,
    float = { border = "single", source = "if_many" },
})

-- Inlay hints on attach (helix shows them for rust by default)
local group = vim.api.nvim_create_augroup("lsp-helix-parity", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/inlayHint", args.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})
