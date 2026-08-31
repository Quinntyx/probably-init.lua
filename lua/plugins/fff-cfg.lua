-- fff file manager bound to <leader>e, mirroring helix's file picker key
-- (space + e). Opens fff in a terminal split (picker mode, -p); pressing
-- enter on a text file opens it in this nvim instance, other files go
-- through xdg-open.
vim.keymap.set("n", "<leader>e", ":F<CR>", { desc = "fff file picker" })