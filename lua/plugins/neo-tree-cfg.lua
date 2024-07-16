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
        },
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
        },
    },
    window = {
        mappings = {
            ["e"] = "none"
        },

    }
})
