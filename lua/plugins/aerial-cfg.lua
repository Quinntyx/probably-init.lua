-- currently not in use, Aerial breaks folding hotkeys

local M = function()
    require("aerial").setup({
        on_attach = function(bufnr)
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        end,
        layout = {
            min_width = { 0.2, 16 },
            resize_to_content = false,
        },
        attach_mode = "global",
        manage_folds = "true",
        link_folds_to_tree = "true",
        link_tree_to_folds = "true",
        keymaps = {},
        filter_kind = false,
        filetypes = { "Neotree", "neo-tree" },

    })

end

vim.keymap.set("n", "<leader>k", "<cmd>AerialToggle right<CR>")

return M
