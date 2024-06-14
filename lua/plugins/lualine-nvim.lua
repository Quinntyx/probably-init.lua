require('lualine').setup({
	options = {
		disabled_filetypes = {
			"aerial",
			"neo-tree",
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = { "location", "progress" },
		lualine_x = { "branch", "diff", "diagnostics" },
		lualine_y = {},
		lualine_z = { "filetype" },
	}
})
