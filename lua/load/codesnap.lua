return {
    {
        "mistricky/codesnap.nvim",
        build = "make",
        config = function() require("plugins.codesnap-cfg") end,
    }
}
