-- Stage 1: bootstrap - leader keys, helix-parity options, plugin loading.

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- UI parity with helix
opt.showmode = false          -- mode lives in the statusline (NOR/INS/SEL)
opt.cursorline = true
opt.cursorlineopt = "number"  -- highlight current line *number* only (helix ui.linenr.selected)
opt.number = true
opt.relativenumber = true     -- helix defaults to relative line numbers
opt.signcolumn = "auto:1"     -- gutter only when needed (git bars; diagnostics use inline text)
opt.foldcolumn = "0"          -- helix has no fold column
opt.laststatus = 3            -- one global statusline, like helix
opt.termguicolors = true
opt.scrolloff = 5
opt.mouse = "a"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"  -- helix: bar cursor in insert

-- clipboard / undo / search
opt.clipboard:append("unnamedplus")  -- helix yanks go to the system clipboard
opt.undofile = true                  -- helix persists undo history
opt.hlsearch = false                 -- helix: matches highlighted only while searching
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- indentation (helix-style per-language tweaks happen in setup-final-fixes)
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- splits
opt.splitright = true  -- helix vsplit opens to the right
opt.splitbelow = true  -- helix hsplit opens below

-- completion / command line
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }
opt.wildoptions = "pum"
opt.path:append("**")  -- `:find` acts as a file picker

-- folds (treesitter foldexpr is wired up by the treesitter module)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false  -- helix starts unfolded; zc/zo work manually
opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 300
opt.list = true  -- indent guides via `leadmultispace` (set in setup-final-fixes)
opt.fillchars = { eob = "~" }  -- helix ~ markers below the buffer

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local utils = require("utils")
local knobs = utils.knobs()

assert(knobs ~= nil)

require("lazy").setup({
    { import = "load.core" },
    knobs.completion.enabled and { import = "load.completion" } or {},
    knobs.ai.enabled and { import = "load.ai" } or {},
    knobs.git.enabled and { import = "load.git" } or {},
})

-- fff file manager keymap: defined at startup so the <leader>e key works
-- even though the fff.vim plugin itself lazy-loads on the :F command.
require("plugins.fff-cfg")
