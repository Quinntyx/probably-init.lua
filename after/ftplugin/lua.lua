local function config()
    require('utils').ft.get_config_fn_by_ft('lua')()
    -- vim.cmd("%s/\t/    /g")
end

vim.defer_fn(
    config,
    0
)
