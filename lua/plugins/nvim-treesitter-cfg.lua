-- nvim-treesitter (main branch) is a parser manager only; highlighting and
-- folding use Neovim builtins. Parser installs require tree-sitter-cli + cc.

local ensure_installed = {
    "bash", "c", "cpp", "css", "cuda", "html", "java", "json",
    "lua", "markdown", "markdown_inline", "python", "query",
    "rust", "slint", "toml", "vim", "vimdoc", "yaml",
}

require("nvim-treesitter").install(ensure_installed)

local group = vim.api.nvim_create_augroup("treesitter-parity", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldenable = false -- helix starts unfolded; zc/zo fold manually
    end,
})
