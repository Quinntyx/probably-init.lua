local function config()
    require('utils').ft.get_config_fn_by_ft('rust')()
    
end

vim.defer_fn(
    config,
    0
)
