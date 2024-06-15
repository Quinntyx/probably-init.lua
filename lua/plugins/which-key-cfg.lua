local wk = require('which-key')

-- we only set labels here, more readable imo
-- each plugins set their own binds in their config callbacks
-- WhichKey is set to VeryLazy, so this should not cause issues
wk.register(
	{
		-- currently disabled, see plugins.aerial-cfg
		-- a = { "Toggle Aerial" },
		g = {
			name = "Git",
			b = { "Toggle Inline Blame" },
			d = { "Toggle Deleted Lines" },
		},
		["<leader>"] = { "File Tree" },
		-- doesn't currently work, see todo.txt
		-- ["/"] = { "Comment Line" },
	},
	{
		prefix = "<leader>"
	}
);
