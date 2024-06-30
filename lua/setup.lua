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

if knobs.lsp == nil then
    vim.notify("Malformed knobs.lua; missing lsp configuration")
end
if knobs.git == nil then
    vim.notify("Malformed knobs.lua  missing git configuration")
end
if knobs.graphics == nil then
    vim.notify("Malformed knobs.lua; missing graphics configuration")
end
if knobs.remote == nil then
    vim.notify("Malformed knobs.lua; missing remote configuration")
end

require("lazy").setup({
    { import = "load.core" },
    knobs.lsp.enabled and { import = "load.lsp" } or {},
    knobs.git.enabled and { import = "load.git" } or {},
    knobs.graphics.enabled and { import = "load.graphics" } or {},
    knobs.remote.enabled and { import = "load.remote" } or {},
})

