local wk = require('which-key')

-- we only set labels here, more readable imo
-- each plugins set their own binds in their config callbacks
-- WhichKey is set to VeryLazy, so this should not cause issues
wk.register(
	{
        { "<leader>g", group = "Git" },
        { "<leader>gb", desc = "Toggle Inline Blame" },
        { "<leader>gd", desc = "Toggle Deleted Lines" },

        { "<leader>k", desc = "Toggle Aerial" },

        { "<leader>l", group = "LSP/Intelligence" },
        { "<leader>la", desc = "Add Documentation" },

        { "<leader>s", group = "Notes" },
        { "<leader>sh", desc = "Daily Note" },
        { "<leader>si", desc = "Index" },
        { "<leader>sg", desc = "Generate Metadata" },
    }
);
