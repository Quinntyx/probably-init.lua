local utils = require("utils")

-- i am not sure why this is necessary, but so be it
require('plugins.nvim-lspconfig-cfg')

local sidepanel_pattern = {
	["aerial"] = true,
	["neo-tree"] = true,
	["neotree"] = true,
}

-- vim.api.nvim_create_autocmd("FileType", {
--     -- pattern = utils.table_to_list(sidepanel_pattern),
--     callback = function()
-- 		-- require("ufo").detach()
-- 		-- vim.opt_local.foldenable = false
-- 		vim.cmd([[
-- 		set foldcolumn=8
-- 		]])
--     end
-- })
--

-- vim.call("Neotree", "show")

vim.api.nvim_set_hl(0, 'CustomVisual', {
    fg = utils.get_hl('Comment').foreground,
    bg = utils.get_hl('Visual').background,
});

vim.cmd([[
set termguicolors
set expandtab
set autoindent
set cursorline
set clipboard+=unnamedplus
set mouse+=a
set number
set scrolloff=5

" Configuring code folding
set fillchars+=foldopen:╭
set fillchars+=foldclose:╾
set fillchars+=foldsep:│

" nvim-ufo provider requires large foldlevel value
set foldlevel=99
set foldlevelstart=99

noremap y h
noremap n j
noremap e k
noremap o l
noremap j y
noremap k n
noremap w e
noremap zx zo
noremap zm zc
" noremap W <C-w>
noremap Wy <C-w>h
noremap Wn <C-w>j
noremap We <C-w>k
noremap Wo <C-w>l
noremap Wq <C-w>q

"" Auto-insert closing parenthesis/brace/quotes
noremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>

"" Expand opening-brace followed by ENTER to a block and place cursor inside
inoremap {<cr> {<cr>}<Esc>O

"" Skip over closing parenthesis/brace
inoremap <expr> ) getline('.')[col('.') - 1] == ")" ? "\<Right>" : ")"
inoremap <expr> } getline('.')[col('.') - 1] == "}" ? "\<Right>" : "}"
inoremap <expr> ] getline('.')[col('.') - 1] == "]" ? "\<Right>" : "]"
inoremap <expr> " getline('.')[col('.') - 1] == "\"" ? "\<Right>" : "\"\"<Left>"
inoremap <expr> ' getline('.')[col('.') - 1] == "\'" ? "\<Right>" : "\'\'<Left>"

" inoremap <expr> l col("$") - 1 == col(".") ? "\<Right>" : ""

]])

function get_line_end()
    if vim.api.nvim_get_mode().mode == "i" then
        return vim.fn.col("$")
    else
        return vim.fn.col("$") - 1
    end
end

function at_line_end()
    return get_line_end() == 1 or get_line_end() == vim.fn.col('.')
end

-- function right_wrapped()
--     for i=1,math.max(vim.v.count, 1) do
--         if at_line_end() then
--             vim.cmd("norm! j0")
--         else
--             vim.cmd('<Right>')
--         end
--     end
-- end
--
-- function left_wrapped()
--     for i=1,math.max(vim.v.count, 1) do
--         if vim.fn.eval("col('0') + 1 == col('.')") == 1 then
--             vim.cmd("norm! k$")
--         else
--             vim.cmd("norm! h")
--         end
--     end
-- end
--
--
-- vim.keymap.set('n', 'y', left_wrapped, { noremap = true })
-- vim.keymap.set('n', 'o', right_wrapped, { noremap = true })
--
-- vim.keymap.set({ 'n', 'i' }, '<Left>', left_wrapped, { noremap = true })
-- vim.keymap.set({ 'n', 'i' }, '<Right>', right_wrapped, { noremap = true })
-- vim.keymap.set('i', '<CR>', enter_fn, eee)

vim.keymap.set('n', 'zx', '<cmd>foldclose')
vim.keymap.set('n', 'zm', '<cmd>foldopen')

function up_snap()
    for i=1,math.max(vim.v.count, 1) do
        if vim.fn.eval("line('.') == 1") == 1 then
            vim.cmd("norm! 0")
        else
            vim.cmd("norm! k")
        end
    end
end

function down_snap()
    for i=1,math.max(vim.v.count, 1) do
        if vim.fn.eval("line('$') == line('.')") == 1 then
            vim.cmd("norm! $")
        else
            vim.cmd("norm! j")
        end
    end
end


vim.cmd([[
set ww+=[,]
]])

vim.keymap.set('n', 'n', down_snap, { noremap = true })
vim.keymap.set('n', 'e', up_snap, { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<Down>', down_snap, { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<Up>', up_snap, { noremap = true })

vim.keymap.set('n', 'R', '<cmd>redo<CR>', { noremap = true })

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

function open_diagnostic()
    vim.diagnostic.open_float({ border = border, header = "", source = true, suffix = " ", severity_sort = true })
end

local function box_type()
    vim.cmd("norm! ma")
    vim.cmd("norm! b")
    vim.cmd("norm! iBox<")
    vim.cmd("norm w")
    vim.cmd("norm! a>")
    vim.cmd("norm! `a")
    vim.cmd("delm a")
end

local function box_value()
    vim.cmd("norm! ma")
    vim.cmd("norm! b")
    vim.cmd("norm! iBox::new(")
    vim.cmd("norm w")
    vim.cmd("norm! a)")
    vim.cmd("norm! `a")
    vim.cmd("delm a")
end

vim.keymap.set('n', 'L', open_diagnostic, { noremap = true })
vim.keymap.set('n', '<leader>lbt', box_type, { desc = "Box a type" })
vim.keymap.set('n', '<leader>lbv', box_value, { desc = "Box a value" })

-- vim.keymap.set('n', 'k', '<cmd>norm! h<CR>', { remap = false })
-- vim.keymap.set('n', 'k', '<cmd>norm! h<CR>', { remap = false })
-- vim.keymap.set('n', 'l', '<cmd>norm! h<CR>', { remap = false })
-- vim.keymap.set('n', ';', '<cmd>norm! h<CR>', { remap = false })

-- vim.cmd([[
-- Neotree
-- ]])
