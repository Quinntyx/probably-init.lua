-- Core plugins: treesitter (parser manager) + which-key (helix-style key menu).

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
        "folke/which-key.nvim",
        enabled = knobs.whichkey.enabled,
        event = "VeryLazy",
        config = function() require("plugins.which-key-cfg") end,
    },
}
