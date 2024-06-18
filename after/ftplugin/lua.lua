local function config()
    require('utils').ft.get_config_fn_by_ft('cpp')()
    
end

vim.defer_fn(
    config,
    0
)
