-- AI completion: harmonize.nvim (rewritten from minuet-ai.nvim) virtual text,
-- backed by local llama.cpp.
-- Loaded at startup (no lazy event): harmonize's FileType autocmd must be
-- registered before any buffer opens, or the per-buffer auto-trigger flag
-- (vim.b.harmonize_virtual_text_auto_trigger) is never set for the first
-- buffer and no completion request is ever sent.
--
-- https://github.com/Quinntyx/harmonize.nvim

return {
    {
        "Quinntyx/harmonize.nvim",
        config = function() require("plugins.minuet-cfg") end,
    },
}
