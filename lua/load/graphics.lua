return {
	{
		'DanilaMihailov/beacon.nvim',
        version = "v1.3.4",
		opts = {},
		config = function() require("plugins.beacon-cfg") end,
	},
    {
        'mcauley-penney/visual-whitespace.nvim',
        config = true
    },
}
