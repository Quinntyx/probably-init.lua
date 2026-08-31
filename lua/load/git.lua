-- Git: gitsigns gutter bars (helix shows git decorations next to line numbers).

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function() require("plugins.gitsigns-cfg") end,
    },
}
