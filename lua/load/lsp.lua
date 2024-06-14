return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"SmiteshP/nvim-navic",
			"williamboman/mason.nvim",
		},
		opts = { },
		config = function() require("plugins.nvim-lspconfig-cfg") end,
	},
	{
		'SmiteshP/nvim-navic',
		opts = {},
		dependencies = {
			'neovim/nvim-lspconfig',
		},
		config = function() require("plugins.navic-cfg") end,
	},
	{
		'williamboman/mason.nvim',
		opts = {},
		config = function() require('plugins.mason-cfg') end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {},
		dependencies = {
			'williamboman/mason.nvim',
		},
		config = function() require('plugins.mason-lspconfig-cfg') end,
	}
}
