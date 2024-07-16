return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() require("plugins.nvim-treesitter-cfg") end
    },
    {
        "sitiom/nvim-numbertoggle",
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = require("plugins.aerial-cfg"),
    },
    {
        "goolord/alpha-nvim",
        opts = {},
        dependencies = {},
        config = function() require("plugins.alpha-cfg") end,
    },
    {
        "danymat/neogen",
        config = function() require('plugins.neogen-cfg') end,
        keys = {
            {
                "<leader>ll",
                "<cmd>Neogen<CR>",
                mode = { "n" },
                desc = "Add Documentation"
            }
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope.nvim',
        },
        config = function() require('plugins.harpoon-cfg') end,
        keys = {
            {
                "<leader>a",
                function()
                    local h = require('harpoon')
                    h:list():add()
                    vim.notify("Harpooned " .. vim.api.nvim_buf_get_name(0))
                end,
                mode = { "n", "v" },
                desc = "Harpoon current buffer",
            },
            {
                "<leader>d",
                function() require('harpoon'):list():clear() end,
                mode = { "n", "v" },
                desc = "Clear Harpoon",
            },
            {
                "<leader>h",
                function()
                    local conf = require("telescope.config").values
                    local harpoon_files = require('harpoon'):list()
                    local file_paths = {}
                    for _, item in ipairs(harpoon_files.items) do
                        table.insert(file_paths, item.value)
                    end

                    require("telescope.pickers").new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    }):find()
                end,
                mode = { "n", "v" },
                desc = "Harpoon buffers",
            },
            {
                "<leader>n",
                function()
                    local h = require('harpoon')
                    if h:list():get(1) ~= nil then
                        h:list():select(1)
                        vim.notify("Harpooned to " .. h:list():get(1).value)
                    else
                        vim.notify("Harpoon 1 is unset")
                    end
                end,
                mode = { "n", "v" },
                desc = "Open Harpooned buffer 1",
            },
            {
                "<leader>e",
                function()
                    local h = require('harpoon')
                    if h:list():get(2) ~= nil then
                        h:list():select(2)
                        vim.notify("Harpooned to " .. h:list():get(2).value)
                    else
                        vim.notify("Harpoon 2 is unset")
                    end
                end,
                mode = { "n", "v" },
                desc = "Open Harpooned buffer 2",
            },
            {
                "<leader>o",
                function()
                    local h = require('harpoon')
                    if h:list():get(3) ~= nil then
                        h:list():select(3)
                        vim.notify("Harpooned to " .. h:list():get(3).value)
                    else
                        vim.notify("Harpoon 3 is unset")
                    end
                end,
                mode = { "n", "v" },
                desc = "Open Harpooned buffer 3",
            },
            {
                "<leader>i",
                function()
                    local h = require('harpoon')
                    if h:list():get(4) ~= nil then
                        h:list():select(4)
                        vim.notify("Harpooned to " .. h:list():get(4).value)
                    else
                        vim.notify("Harpoon 4 is unset")
                    end
                end,
                mode = { "n", "v" },
                desc = "Open Harpooned buffer 4",
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('plugins.telescope-cfg') end,
        keys = {
            {
                "<leader><leader>",
                function() vim.cmd("Telescope find_files") end,
                mode = { "n", "v" },
                desc = "File explorer",
            },
        },
    },
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function() require('plugins.window-picker-cfg') end,
        keys = {
            {
                "<leader>w",
                function()
                    local window = require('window-picker').pick_window()
                    if window ~= nil then
                        vim.api.nvim_set_current_win(window)
                    end
                end,
                mode = { "n", "v" },
                desc = "Pick window"
            },
        }
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        opts = {
            rocks = { "magick", }
        }
    },
    {
        "3rd/image.nvim",
        dependencies = { "vhyrro/luarocks.nvim", },
        config = function() require("plugins.image-cfg") end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        },
        config = function() require("plugins.neo-tree-cfg") end,
        keys = {
            {
                "<leader>u",
                function() vim.cmd("Neotree float") end,
                mode = { "n", "v" },
                desc = "File Tree",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function() require("plugins.lualine-cfg") end,
    },
    -- barless superiority
    -- {
    --     "romgrk/barbar.nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
    --     init = function() vim.g.barbar_auto_setup = false end,
    --     config = function() require("plugins.barbar-cfg") end,
    -- },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "stevearc/aerial.nvim",

        },
        opts = {},
        config = function() require("plugins.ufo-cfg") end,
    },
    {
        'numToStr/Comment.nvim',
        opts = { },
        config = function() require("plugins.comment-cfg") end,
    },
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = { },
        config = function() require('plugins.which-key-cfg') end,
    },
    {
        'rcarriga/nvim-notify',
        opts = {},
        config = function() require('plugins.nvim-notify-cfg') end,
        lazy = false,
        priority = 1000000, -- load early so that if other plugins load, they can print prettily :3
    },
}
