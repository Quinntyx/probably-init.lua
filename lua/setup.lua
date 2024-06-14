if false then vim = require('') end

vim.cmd([[
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cc=120
set cursorline
set clipboard+=unnamedplus
set mouse+=a
set number
set scrolloff=5

" Configuring code folding
set foldenable
set foldcolumn=8
set fillchars+=foldopen:╭
set fillchars+=foldclose:╾
set fillchars+=foldsep:│

" nvim-ufo provider requires large foldlevel value
set foldlevel=99
set foldlevelstart=99

noremap o l
noremap e k
noremap n j
noremap y h
noremap j y
noremap zx zo
noremap zm zc
noremap k n
noremap w e
noremap W <C-w>
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

local knobs = require("knobs")

-- local lazy_opts = {
-- 	{ import = "load.core" },
-- }
--
--
-- if knobs.lsp then
-- 	lazy_opts[#lazy_opts + 1] = { import = "load.lsp" }
-- end
-- if knobs.git then
-- 	lazy_opts[#lazy_opts + 1] = { import = "load.git" }
-- end
-- if knobs.beacon then
-- 	lazy_opts[#lazy_opts + 1] = { import = "load.beacon" }
-- end
-- require("lazy").setup(lazy_opts)

require("lazy").setup({
    { import = "load.core" },
    knobs.lsp and { import = "load.lsp" } or nil,
    knobs.git and { import = "load.git" } or nil,
    knobs.beacon and { import = "load.beacon" } or nil,
})

