require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    vault = "~/docs/neorg",
                },
                default_workspace = "vault",
            }
        },
        ["core.journal"] = {
            config = {
                journal_folder = "daily",
                strategy = "flat",
                template_name = "daily_template.norg",
                workspace = "vault",
            },
        },
        ["core.export"] = { },
        ["core.esupports.metagen"] = {
            config = {
                type = "auto",
                template = {
                    { 'title', '' },
                    { 'categories', 'stub' },
                    { 'created', function() return os.date('%Y-%m-%d') end },
                    { 'created', function() return os.date('%Y-%m-%d') end },
                    { 'version', '0.1.0' },
                    { 'sources', '' },
                }
            }
        },
        ["core.integrations.image"] = {},
        ["core.latex.renderer"] = {
            config = {
                render_on_enter = true,
                conceal = false,
                dpi = 600,
                scale = 2.5,
            },
        },
    }
})

