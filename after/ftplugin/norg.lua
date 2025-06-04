local function config()
    require('utils').ft.get_config_fn_by_ft('norg')()
    vim.opt_local.wrap = true
    vim.opt.textwidth = require('ft.norg').line_length
end

vim.api.nvim_create_autocmd('ModeChanged', {
    callback = function()
        if vim.bo.filetype ~= "norg" then
            return
        end
        local new_mode = vim.v.event.new_mode

        if new_mode == 'i' then
            vim.cmd("Neorg render-latex disable")
        else
            vim.cmd("Neorg render-latex")
        end
    end
})

vim.defer_fn(
    config,
    0
)
