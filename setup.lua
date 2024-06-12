vim.cmd([[
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cc=120
set cursorline
noremap o l
noremap e k
noremap n j
noremap y h
noremap j y
map zm zc
set clipboard+=unnamedplus
set mouse+=a
set number
set foldcolumn=8
set scrolloff=5
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


require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", 
		config = require("plugins.nvim-treesitter")
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		}
	},
	{
		"goolord/alpha-nvim",
		opts = {},
		dependencies = {},
		config = require("plugins.alpha-nvim"),
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = require("plugins.neo-tree-nvim"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.lualine-nvim"),
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		init = function() vim.g.barbar_auto_setup = false end,
		config = require("plugins.barbar-nvim"),
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { },
		config = require("plugins.gitsigns-nvim"),
	},
})
