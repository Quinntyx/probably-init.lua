return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"SmiteshP/nvim-navic",
			"williamboman/mason.nvim",
		},
		opts = { },
		config = function() require("plugins.nvim-lspconfig") end,
	},
	{
		'SmiteshP/nvim-navic',
		opts = {},
		dependencies = {
			'neovim/nvim-lspconfig',
		},
		config = function() require("plugins.nvim-navic") end,
	},
	{
		'williamboman/mason.nvim',
		opts = {},
		config = function() require('plugins.mason-nvim') end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {},
		dependencies = {
			'williamboman/mason.nvim',
		},
		config = function() require('plugins.mason-lspconfig-nvim') end,
	}
}
