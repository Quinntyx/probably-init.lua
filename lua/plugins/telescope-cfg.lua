local actions = require("telescope.actions")
local u = require('utils')
local knobs = u.knobs()

assert(knobs ~= nil)

local open_with_trouble = nil
if knobs.lsp.enabled then
    open_with_trouble = require("trouble.sources.telescope").open
end

local telescope = require("telescope")

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["<leader>x"] = knobs.lsp.enabled and open_with_trouble or function() vim.notify("Trouble unavailable, LSP is disabled") end,
                ["<leader><leader>"] = require('telescope.builtin').find_files
            },
        },
    },
})
