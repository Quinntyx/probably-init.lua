-- AI completion: minuet-ai.nvim virtual text, backed by local llama.cpp.
-- Loaded at startup (no lazy event): minuet's FileType autocmd must be
-- registered before any buffer opens, or the per-buffer auto-trigger flag
-- (vim.b.minuet_virtual_text_auto_trigger) is never set for the first
-- buffer and no completion request is ever sent.
--
-- Uses the fork of milanglacier/minuet-ai.nvim that adds chunk-based
-- acceptance and the single-line virtual text display option.

return {
    {
        "Quinntyx/minuet-ai.nvim",
        config = function() require("plugins.minuet-cfg") end,
    },
}