-- Core plugins: treesitter (parser manager) + which-key (helix-style key menu)
-- + fff (fff.nvim): fuzzy file picker on <leader>e (helix parity).

local knobs = require("utils").knobs()

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- nvim-treesitter (main branch) does not support lazy-loading
        build = ":TSUpdate",
        enabled = knobs.treesitter.enabled,
        config = function() require("plugins.nvim-treesitter-cfg") end,
    },
    {
        "dmtrKovalenko/fff",
        build = function()
            -- downloads a prebuilt fff.nvim binary, falls back to a cargo build
            require("fff.download").download_or_build_binary()
        end,
        lazy = false, -- the plugin initializes its own state on startup
        keys = {
            {
                "<leader>e",
                function() require("fff").find_files() end,
                desc = "fff: find files",
            },
        },
    },
    {
        "folke/which-key.nvim",
        enabled = knobs.whichkey.enabled,
        event = "VeryLazy",
        config = function() require("plugins.which-key-cfg") end,
    },
}
