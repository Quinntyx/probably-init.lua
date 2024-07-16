vim.notify("Loading Neorg")

return {
    {
        "nvim-neorg/neorg",
        lazy = false,
        dependencies = {
            "3rd/image.nvim",
        },
        keys = {
            {
                "<leader>sn",
                function()
                    local dirman = require('neorg').modules.get_module("core.dirman")
                    dirman.create_file("my_file", "my_ws", {
                        no_open  = false,  -- open file after creation?
                        force = false,  -- overwrite file if exists
                        metadata = {}      -- key-value table for metadata fields
                    })
                end,
                mode = { 'n' },
            },
            {
                "<leader>sh",
                "<cmd>Neorg journal today<CR>",
                mode = { 'n' },
            },
            {
                "<leader>si",
                "<cmd>Neorg index<CR>",
                mode = { 'n' },
            },
            {
                "<leader>sg",
                "<cmd>Neorg inject-metadata",
                mode = { 'n' },
            },
        },
    },
}
