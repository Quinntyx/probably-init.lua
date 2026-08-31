-- nvim-cmp, configured to feel like helix's bundled completion:
-- menu pops automatically with the first item preselected, Enter accepts,
-- Esc aborts. Flat menu (no border) like helix.
--
-- Tab/S-Tab are copilot-style: a visible harmonize ghost suggestion is
-- accepted one chunk at a time (Tab) or cycled (S-Tab) first; otherwise
-- cmp menu cycling; otherwise fallback (literal tab / indent). harmonize's
-- own M- keys still work as a backup.

local cmp = require("cmp")

local function harmonize_visible()
    local ok, vt = pcall(require, "harmonize.virtualtext")
    return ok and vt.action.is_visible()
end

cmp.setup({
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    preselect = cmp.PreselectMode.Item,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if harmonize_visible() then
                require("harmonize.virtualtext").action.accept_chunk()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if harmonize_visible() then
                require("harmonize.virtualtext").action.prev()
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Helix `:` command mode shows completion as well
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
