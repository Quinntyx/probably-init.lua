-- AI completion: harmonize.nvim (the v2 rewrite of minuet-ai.nvim) virtual text,
-- backed by local llama.cpp.
-- Loaded at startup (no lazy event): harmonize's FileType autocmd must be
-- registered before any buffer opens, or the per-buffer auto-trigger flag
-- (vim.b.harmonize_virtual_text_auto_trigger) is never set for the first
-- buffer and no completion request is ever sent.
--
-- Fork of milanglacier/minuet-ai.nvim living on the v2 branch; see
-- https://github.com/Quinntyx/minuet-ai.nvim/tree/v2.

return {
    {
        "Quinntyx/minuet-ai.nvim",
        branch = "v2",
        config = function() require("plugins.minuet-cfg") end,
    },
}