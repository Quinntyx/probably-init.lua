return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "SmiteshP/nvim-navic",
            "williamboman/mason.nvim",
        },
        opts = { },
        -- see setup-final-fixes.lua, i am calling this there
        -- config = function() print("test"); require("plugins.nvim-lspconfig-cfg") end,
        config = function() end,
    },
    {
        'SmiteshP/nvim-navic',
        opts = {},
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function() require("plugins.navic-cfg") end,
    },
    {
        'williamboman/mason.nvim',
        opts = {},
        config = function() require('plugins.mason-cfg') end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {},
        dependencies = {
            'williamboman/mason.nvim',
        },
        config = function() require('plugins.mason-lspconfig-cfg') end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function() require('plugins.nvim-cmp-cfg') end,
    }
}
