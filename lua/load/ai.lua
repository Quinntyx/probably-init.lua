-- AI completion: minuet-ai.nvim virtual text, backed by local llama.cpp.
-- Loaded at startup (no lazy event): minuet's FileType autocmd must be
-- registered before any buffer opens, or the per-buffer auto-trigger flag
-- (vim.b.minuet_virtual_text_auto_trigger) is never set for the first
-- buffer and no completion request is ever sent.

return {
    {
        "milanglacier/minuet-ai.nvim",
        config = function() require("plugins.minuet-cfg") end,
    },
}