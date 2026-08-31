-- Stage 3: helix-parity keymaps (Workman layout), auto-pairs, indent
-- guides, statusline, and LSP wiring.

local map = vim.keymap.set

-- ==========================================
-- Workman movement (mirrors helix keys.normal)
-- ==========================================
-- Movement is remapped in normal + visual ("select") modes; operator-pending
-- stays native so dw / dh / d} etc. keep working.

map({ "n", "v" }, "y", "h", { desc = "Move left" })
map({ "n", "v" }, "n", "j", { desc = "Move down" })
map({ "n", "v" }, "e", "k", { desc = "Move up" })

-- Left/right wrap around line boundaries: y (left) at the first char goes to
-- the end of the previous line; o (right) at the last char goes to the
-- start of the next line. Empty lines wrap as well.
local function move_left_wrap()
    local cursor = vim.api.nvim_win_get_cursor(0)
    if cursor[2] == 0 then
        if cursor[1] > 1 then
            local prev = vim.api.nvim_buf_get_lines(0, cursor[1] - 2, cursor[1] - 1, false)[1] or ""
            -- land on the last char of the previous line (nvim's "end of line")
            vim.api.nvim_win_set_cursor(0, { cursor[1] - 1, math.max(#prev - 1, 0) })
        end
    else
        vim.cmd("normal! h")
    end
end

local function move_right_wrap()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1] or ""
    if cursor[2] >= #line - 1 then
        if cursor[1] < vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, 0 })
        end
    else
        vim.cmd("normal! l")
    end
end

map({ "n", "v" }, "y", move_left_wrap, { desc = "Move left (wraps to prev line end)" })
map({ "n", "v" }, "o", move_right_wrap, { desc = "Move right (wraps to next line start)" })

-- Displaced keys (mirrors helix displaced keys + uppercase counterparts)
map("n", "j", "yy", { desc = "Yank line" })
map("v", "j", "y", { desc = "Yank selection" })
map("n", "J", "yy", { desc = "Yank (joined)" })
map("v", "J", "y", { desc = "Yank selection" })
map({ "n", "v" }, "h", "n", { desc = "Search next" })
map({ "n", "v" }, "H", "N", { desc = "Search previous" })
map({ "n", "v" }, "l", "e", { desc = "Move next word end" })
map({ "n", "v" }, "L", "E", { desc = "Move next long word end" })
map("n", "k", "o", { desc = "Open line below" })
map("n", "K", "O", { desc = "Open line above" })

-- Helix x: select current line (works with counts, extends with n/e)
map({ "n", "v" }, "x", "V", { desc = "Select current line" })
map("v", ";", "<Esc>", { desc = "Collapse selection" })

-- Helix U: redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- ==========================================
-- Window navigation (helix C-w and space-w)
-- ==========================================
local function window_maps(prefix)
    local jump = { y = "h", n = "j", e = "k", o = "l" }
    local swap = { Y = "H", N = "J", E = "K", O = "L" }
    for key, dir in pairs(jump) do
        map("n", prefix .. key, "<C-w>" .. dir, { desc = "Jump window " .. dir })
    end
    for key, dir in pairs(swap) do
        map("n", prefix .. key, "<C-w>" .. dir, { desc = "Swap window " .. dir })
    end
end

window_maps("<C-w>")
window_maps("<space>w")

-- ==========================================
-- Helix space menu equivalents
-- ==========================================
map({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<space>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<space>s", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<space>k", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<space>d", vim.lsp.buf.document_symbol, { desc = "Document symbols" })

-- Pickers via builtins (helix space+f / space+b); fuzzy upgrade can come later
map("n", "<space>f", ":find ", { desc = "Find file" })
map("n", "<space>b", ":buffer ", { desc = "Buffer picker" })

-- Goto (helix gd / gr / gy / gi)
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto type definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })

-- Goto line start / end (helix gh / gl); operator-pending included so
-- dgl / dgh behave as motions
map({ "n", "v", "o" }, "gh", "0", { desc = "Goto line start" })
map({ "n", "v", "o" }, "gl", "$", { desc = "Goto line end" })

-- ==========================================
-- Helix-style auto-pairs (insert mode)
-- ==========================================
map("i", "(", "()<Left>")
map("i", "[", "[]<Left>")
map("i", "{", "{}<Left>")
map("i", "{<cr>", "{<cr>}<Esc>O")

local function skip_or_type(closer, fallback)
    return function()
        local col = vim.fn.col(".")
        if vim.fn.getline("."):sub(col, col) == closer then
            return "<Right>"
        end
        return fallback
    end
end

local expr = { expr = true, replace_keycodes = true }
map("i", ")", skip_or_type(")", ")"), expr)
map("i", "}", skip_or_type("}", "}"), expr)
map("i", "]", skip_or_type("]", "]"), expr)
map("i", '"', skip_or_type('"', '""<Left>'), expr)
map("i", "'", skip_or_type("'", "''<Left>"), expr)

-- ==========================================
-- Indent guides + per-language indentation (helix defaults)
-- ==========================================
local group = vim.api.nvim_create_augroup("helix-parity", { clear = true })

local two_space_fts = {
    lua = true, json = true, jsonc = true, yaml = true,
    toml = true, norg = true, c = true, cpp = true,
}

local function indent_guides()
    local sw = vim.bo.shiftwidth > 0 and vim.bo.shiftwidth or vim.bo.tabstop
    vim.opt_local.listchars = "leadmultispace:" .. "│" .. string.rep(" ", math.max(sw - 1, 1))
end

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        if two_space_fts[vim.bo[args.buf].filetype] then
            vim.bo[args.buf].shiftwidth = 2
            vim.bo[args.buf].tabstop = 2
            vim.bo[args.buf].softtabstop = 2
        end
        indent_guides()
    end,
})

-- ==========================================
-- Statusline + LSP
-- ==========================================
require("statusline").setup()

local knobs = require("utils").knobs()
if knobs.lsp.enabled then
    require("load.lsp")
end
