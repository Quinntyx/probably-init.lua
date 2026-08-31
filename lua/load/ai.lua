-- AI completion: minuet-ai.nvim virtual text, backed by local llama.cpp.

return {
    {
        "milanglacier/minuet-ai.nvim",
        event = "InsertEnter",
        config = function() require("plugins.minuet-cfg") end,
    },
}