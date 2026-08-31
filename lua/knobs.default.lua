return {
    lsp = {
        -- native vim.lsp with system servers (helix parity: enable what is in PATH)
        enabled = true,
    },
    completion = {
        -- nvim-cmp + LuaSnip (helix bundles tab-complete)
        enabled = true,
    },
    ai = {
        -- harmonize-ai.nvim AI tab-completion (virtual text) via local llama.cpp
        enabled = true,
    },
    git = {
        -- gitsigns gutter bars (helix shows git decorations)
        enabled = true,
    },
    treesitter = {
        -- parser manager + builtins for highlight/folds (helix bundles grammars)
        -- requires tree-sitter-cli + a C compiler to install parsers
        enabled = true,
    },
    colorscheme = {
        -- custom everforest light transparent (helix everforest_light_transparent)
        enabled = true,
    },
    whichkey = {
        -- key menu, like helix's builtin pending-keys popup
        enabled = true,
    },
}
