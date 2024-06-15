return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", 
		config = function() require("plugins.nvim-treesitter-cfg") end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	-- Aerial breaks zx zm custom fold hotkeys, so it's currently removed. If I can get it to work later, I'll
	-- uncomment it. 
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = require("plugins.aerial-nvim"),
	-- },
	--
	-- incompatible with barbar, will never be shown. Will readd when issue fixed
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	opts = {},
	-- 	dependencies = {},
	-- 	config = function() require("plugins.alpha-nvim") end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = function() require("plugins.neo-tree-cfg") end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("plugins.lualine-cfg") end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		init = function() vim.g.barbar_auto_setup = false end,
		config = function() require("plugins.barbar-cfg") end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {},
		config = function() require("plugins.ufo-cfg") end,
	},
	{
		'numToStr/Comment.nvim',
		opts = { },
		config = function() require("plugins.comment-cfg") end,
	},
	{
		'folke/which-key.nvim',
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = { },
		config = function() require('plugins.which-key-cfg') end,
	}
}
