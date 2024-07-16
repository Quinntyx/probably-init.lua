return {
	{
		'DanilaMihailov/beacon.nvim',
        version = "v1.3.4",
		opts = {},
		config = function() require("plugins.beacon-cfg") end,
	},
    {
        'mcauley-penney/visual-whitespace.nvim',
        config = function() require("plugins.visual-whitespace-cfg") end,
        opts = {},
    },
-- I don't like precignition as much as I was expecting. 
--     {
--         'tris203/precognition.nvim',
--         opts = {
--             showBlankVirtLine = false,
--             highlightColor = { link = "Comment" }
--         },
--     },
}
