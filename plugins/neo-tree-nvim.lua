local M = function()
	require("neo-tree").setup({
		close_if_last_window = true,
		default_component_configs = {
			type = {
				enabled = true,
				required_width = 10,
			}
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			}
		},
		window = {
			mappings = {
				["e"] = "none"
			},
		}
	})
end

return M
