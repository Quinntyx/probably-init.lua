local file_exists_and_is_empty = function(filepath)
    local file = io.open(filepath, "r") -- Open the file in read mode
    if file ~= nil then
        local content = file:read("*all") -- Read the entire content of the file
        file:close()                      -- Close the file
        return content == ""              -- Check if the content is empty
    else
        return false
    end
end

-- local function journal()
--     vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
--         desc = "Autoload template for notes/journal",
--         pattern = '*.norg',
--         callback = function(args)
--             local index = "index.norg"
--             vim.schedule(function()
--                 if vim.fn.fnamemodify(args.file, ":t") == index then
--                     return
--                 end
--                 if args.event == "BufNewFile"
--                     or (args.event == "BufNew"
--                     and file_exists_and_is_empty(args.file)) then
--                     vim.api.nvim_cmd({
--                         cmd = "Neorg",
--                         args = { "templates", "fload", template_name },
--                     }, {})
--                 end
--             end)
--         end,
--     })
-- end

return {
    {
        "nvim-neorg/neorg",
        lazy = false,
        dependencies = {
            "3rd/image.nvim",
        },
        config = function() require('plugins.neorg-cfg') end,
        keys = {
            {
                "<leader>sn",
                function()
                    local dirman = require('neorg').modules.get_module("core.dirman")
                    dirman.create_file("my_file", "my_ws", {
                        no_open  = false,  -- open file after creation?
                        force = false,  -- overwrite file if exists
                        metadata = {}      -- key-value table for metadata fields
                    })
                end,
                mode = { 'n' },
            },
            {
                "<leader>sh",
                function()
                    vim.cmd([[Neorg journal today]])
                    if vim.fn.getline(1, '$') == { ' ' } then
                        vim.cmd([[Neorg inject-metadata]])
                        vim.cmd([[%s/stub/daily/g]])
                        vim.cmd([[norm! G]])
                    end
                    vim.cmd([[norm! O]])
                    vim.cmd([[norm! dd]])
                end,
                mode = { 'n' },
            },
            {
                "<leader>si",
                "<cmd>Neorg index<CR>",
                mode = { 'n' },
            },
            {
                "<leader>sg",
                "<cmd>Neorg inject-metadata<CR>",
                mode = { 'n' },
            },
        },
    },
}
