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
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json" },
    },
    clangd = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    },
    jdtls = {
        cmd = { "jdtls" },
        filetypes = { "java" },
        root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
        init_options = {
            extendedClientCapabilities = { classFileContentsSupport = true },
        },
    },
    ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    },
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
    },
    lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".git" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
            },
        },
    },
    html = { cmd = { "vscode-html-language-server", "--stdio" }, filetypes = { "html" } },
    cssls = { cmd = { "vscode-css-language-server", "--stdio" }, filetypes = { "css", "scss", "less" } },
    slint_lsp = { cmd = { "slint-lsp" }, filetypes = { "slint" } },
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

-- Inlay hints are disabled entirely: rust-analyzer's type inlays were too
-- noisy here (and nvim's inlay-hint provider has the "Invalid 'col'" crash
-- bug, neovim/neovim#39772 — unfixed in 0.12.x).
-- To re-enable for a server, add its name, e.g. { rust_analyzer = true }.
local inlay_hint_servers = {}

local group = vim.api.nvim_create_augroup("lsp-helix-parity", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and inlay_hint_servers[client.name]
            and client:supports_method("textDocument/inlayHint", args.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})
