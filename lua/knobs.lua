return {
	lsp = {
		-- requires nodejs
		enabled = true,
	},
	git = {
		enabled = true
	},
	graphics = {
		enabled = true,
	},
	remote = {
		-- requires sshfs (a FUSE filesystem), may not work on non-Linux host systems. 
		enabled = true,
		ssh_extra_configs = {
			"/etc/ssh/ssh_config",
			-- "/path/to/custom/ssh_config"
		}
	},
}
