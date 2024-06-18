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
noremap W <C-w>
noremap Wy <C-w>h
noremap Wn <C-w>j
noremap We <C-w>k
noremap Wo <C-w>l
]])

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

local utils = require('utils')
local knobs = utils.knobs()

require("lazy").setup({
    { import = "load.core" },
    knobs.lsp.enabled and { import = "load.lsp" } or nil,
    knobs.git.enabled and { import = "load.git" } or nil,
    knobs.graphics.enabled and { import = "load.graphics" } or nil,
    knobs.remote.enabled and { import = "load.remote" } or nil,
})

