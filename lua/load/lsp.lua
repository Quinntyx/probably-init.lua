return {
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
    },
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
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        dependencies = {
            'nvim-telescope/telescope.nvim'
        },
        keys = {
            -- {
            --     "<leader>x",
            --     function() require("trouble.sources.telescope").open(0, {}) end,
            --     desc = "Open Trouble"
            -- },
            -- {
            --     "<leader>xx",
            --     "<cmd>Trouble diagnostics toggle<cr>",
            --     desc = "Diagnostics (Trouble)",
            -- },
            -- {
            --     "<leader>xX",
            --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            --     desc = "Buffer Diagnostics (Trouble)",
            -- },
            -- {
            --     "<leader>cs",
            --     "<cmd>Trouble symbols toggle focus=false<cr>",
            --     desc = "Symbols (Trouble)",
            -- },
            -- {
            --     "<leader>cl",
            --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            --     desc = "LSP Definitions / references / ... (Trouble)",
            -- },
            -- {
            --     "<leader>xL",
            --     "<cmd>Trouble loclist toggle<cr>",
            --     desc = "Location List (Trouble)",
            -- },
            -- {
            --     "<leader>xQ",
            --     "<cmd>Trouble qflist toggle<cr>",
            --     desc = "Quickfix List (Trouble)",
            -- },
        },
        config = function() require('plugins.trouble-cfg') end,
    }
}
