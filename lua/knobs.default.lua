return {
    lsp = {
        -- requires nodejs
        enabled = true,
    },
    git = {
        enabled = true,
    },
    graphics = {
        -- saves CPU cycles, this module mostly relates to animations (nvim-notify, beacon)
        enabled = true,
    },
    remote = {
        -- requires sshfs (a FUSE filesystem), may not work on non-Linux host systems. 
        enabled = false,
        ssh_extra_configs = {
            "/etc/ssh/ssh_config",
            -- "/path/to/custom/ssh_config"
        }
    },
    colorscheme = {
        enabled = true,
    },
    codesnap = {
        enabled = true,
    },
    firenvim = {
        enabled = true,
    },
    neorg = {
        enabled = true,
    }
}
