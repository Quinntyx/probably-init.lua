-- everforest (Light Medium) — ported from helix's everforest_light theme:
--   /usr/lib/helix/runtime/themes/everforest_light.toml
-- with `ui.background` transparent, matching
--   ~/.config/helix/themes/everforest_light_transparent.toml

vim.o.background = "light"
vim.g.colors_name = "everforest"

local c = {
    bg_dim = "#efebd4",
    bg0 = "#fdf6e3",
    bg1 = "#f4f0d9",
    bg2 = "#efebd4",
    bg3 = "#e6e2cc",
    bg4 = "#e0dcc7",
    bg5 = "#bdc3af",
    bg_red = "#fbe3da",
    bg_visual = "#eaedc8",
    bg_yellow = "#faedcd",
    bg_green = "#f0f1d2",
    bg_blue = "#e9f0e9",
    fg = "#5c6a72",
    red = "#f85552",
    orange = "#f57d26",
    yellow = "#dfa000",
    green = "#8da101",
    blue = "#3a94c5",
    aqua = "#35a77c",
    purple = "#df69ba",
    grey0 = "#a6b0a0",
    grey1 = "#939f91",
    grey2 = "#829181",
    statusline1 = "#93b259",
    statusline2 = "#708089",
    statusline3 = "#e66868",
    none = "NONE",
}

local hi = function(name, spec) vim.api.nvim_set_hl(0, name, spec) end

-- ---- base (transparent, like everforest_light_transparent) ----
hi("Normal", { fg = c.fg, bg = c.none })
hi("NormalNC", { fg = c.fg, bg = c.none })
hi("NormalFloat", { fg = c.fg, bg = c.bg2 })
hi("FloatBorder", { fg = c.grey1, bg = c.bg2 })
hi("FloatTitle", { fg = c.fg, bg = c.bg2, bold = true })
hi("EndOfBuffer", { fg = c.grey0, bg = c.none })
hi("NonText", { fg = c.grey0, bg = c.none })
hi("Whitespace", { fg = c.bg4, bg = c.none }) -- indent guides
hi("MsgArea", { fg = c.fg, bg = c.none })
hi("SignColumn", { bg = c.none })

-- ---- cursor / selection ----
hi("Cursor", { fg = c.bg1, bg = c.grey2 })
hi("lCursor", { fg = c.bg0, bg = c.grey1 })
hi("CursorIM", { fg = c.bg0, bg = c.blue })
hi("CursorColumn", { bg = c.bg1 })
hi("CursorLine", { bg = c.none }) -- cursorlineopt=number only tints the line number
hi("CursorLineNr", { fg = c.grey2 })
hi("LineNr", { fg = c.grey0 })
hi("Visual", { bg = c.bg3 })
hi("VisualNOS", { bg = c.bg3 })
hi("MatchParen", { bg = c.bg4, bold = true })

-- ---- statusline (helix ui.statusline*) ----
hi("StatusLine", { fg = c.grey2, bg = c.bg3 })
hi("StatusLineNC", { fg = c.grey0, bg = c.bg1 })
hi("User1", { fg = c.bg0, bg = c.statusline1, bold = true }) -- NOR
hi("User2", { fg = c.bg0, bg = c.statusline2, bold = true }) -- INS
hi("User3", { fg = c.bg0, bg = c.blue, bold = true })        -- SEL
hi("User4", { fg = c.bg0, bg = c.statusline3, bold = true }) -- CMD/REP/TER
hi("ModeMsg", { fg = c.grey2 })
hi("MoreMsg", { fg = c.green })
hi("Question", { fg = c.green })
hi("ErrorMsg", { fg = c.red })
hi("WarningMsg", { fg = c.yellow })

-- ---- windows / menus ----
hi("WinSeparator", { fg = c.bg4, bg = c.none })
hi("VertSplit", { link = "WinSeparator" })
hi("Pmenu", { fg = c.fg, bg = c.bg3 })
hi("PmenuSel", { fg = c.bg0, bg = c.green })
hi("PmenuSbar", { bg = c.bg2 })
hi("PmenuThumb", { bg = c.grey0 })
hi("PmenuKind", { fg = c.grey1, bg = c.bg3 })
hi("PmenuKindSel", { fg = c.bg0, bg = c.green })
hi("PmenuExtra", { fg = c.grey1, bg = c.bg3 })
hi("PmenuExtraSel", { fg = c.bg0, bg = c.green })
hi("PmenuMatch", { fg = c.green, bg = c.bg3, bold = true })
hi("PmenuMatchSel", { fg = c.bg0, bg = c.green, bold = true })
hi("WildMenu", { fg = c.bg0, bg = c.green })
hi("QuickFixLine", { bg = c.bg2 })

-- ---- search ----
hi("Search", { bg = c.bg4 })
hi("IncSearch", { fg = c.bg0, bg = c.grey2 })
hi("CurSearch", { fg = c.bg0, bg = c.grey2, bold = true })
hi("Substitute", { fg = c.bg0, bg = c.yellow })

-- ---- legacy syntax groups (kept in sync with treesitter captures) ----
hi("Comment", { fg = c.grey1, italic = true })
hi("Constant", { fg = c.fg })
hi("String", { fg = c.aqua })
hi("Character", { fg = c.aqua })
hi("Number", { fg = c.purple })
hi("Boolean", { fg = c.purple })
hi("Float", { fg = c.purple })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.green })
hi("Statement", { fg = c.red })
hi("Keyword", { fg = c.red })
hi("Operator", { fg = c.orange })
hi("PreProc", { fg = c.purple })
hi("Include", { fg = c.purple })
hi("Macro", { fg = c.green })
hi("Type", { fg = c.yellow })
hi("StorageClass", { fg = c.red })
hi("Structure", { fg = c.red })
hi("Typedef", { fg = c.red })
hi("Special", { fg = c.blue })
hi("SpecialChar", { fg = c.green })
hi("Tag", { fg = c.orange })
hi("Delimiter", { fg = c.grey1 })
hi("SpecialComment", { fg = c.grey1, italic = true })
hi("Label", { fg = c.orange })
hi("Underlined", { underline = true })
hi("Bold", { bold = true })
hi("Italic", { italic = true })
hi("Title", { fg = c.green, bold = true })
hi("Todo", { fg = c.yellow, bold = true })
hi("Directory", { fg = c.green })
hi("Error", { fg = c.red })
hi("Folded", { fg = c.grey1, bg = c.bg1 })
hi("FoldColumn", { fg = c.grey0 })

-- ---- treesitter captures (helix mapping) ----
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.purple, italic = true })
hi("@variable.parameter", { fg = c.fg })
hi("@variable.member", { fg = c.blue })
hi("@variable.global", { fg = c.fg })
hi("@constant", { fg = c.fg })
hi("@constant.builtin", { fg = c.purple, italic = true })
hi("@constant.macro", { fg = c.purple })
hi("@boolean", { fg = c.purple })
hi("@number", { fg = c.purple })
hi("@float", { fg = c.purple })
hi("@string", { fg = c.aqua })
hi("@string.escape", { fg = c.green })
hi("@string.regexp", { fg = c.green })
hi("@string.special", { fg = c.yellow })
hi("@comment", { fg = c.grey1, italic = true })
hi("@keyword", { fg = c.red })
hi("@keyword.function", { fg = c.red })
hi("@keyword.operator", { fg = c.orange })
hi("@keyword.directive", { fg = c.purple })
hi("@keyword.storage", { fg = c.red })
hi("@label", { fg = c.orange })
hi("@operator", { fg = c.orange })
hi("@punctuation.delimiter", { fg = c.grey1 })
hi("@punctuation.bracket", { fg = c.fg })
hi("@punctuation.special", { fg = c.blue })
hi("@function", { fg = c.green })
hi("@function.builtin", { fg = c.green })
hi("@function.macro", { fg = c.green })
hi("@constructor", { fg = c.green })
hi("@type", { fg = c.yellow })
hi("@type.builtin", { fg = c.yellow })
hi("@type.qualifier", { fg = c.red })
hi("@module", { fg = c.yellow, italic = true })
hi("@tag", { fg = c.orange })
hi("@tag.delimiter", { fg = c.grey1 })
hi("@attribute", { fg = c.purple, italic = true })
hi("@property", { fg = c.blue })

-- ---- markup (helix markup.*) ----
hi("@markup.heading.marker", { fg = c.grey1 })
hi("@markup.heading.1", { fg = c.red, bold = true })
hi("@markup.heading.2", { fg = c.orange, bold = true })
hi("@markup.heading.3", { fg = c.yellow, bold = true })
hi("@markup.heading.4", { fg = c.green, bold = true })
hi("@markup.heading.5", { fg = c.blue, bold = true })
hi("@markup.heading.6", { fg = c.purple, bold = true })
hi("@markup.list", { fg = c.red })
hi("@markup.bold", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.link.url", { fg = c.blue, underline = true })
hi("@markup.link.label", { fg = c.orange })
hi("@markup.link", { fg = c.purple })
hi("@markup.quote", { fg = c.grey1 })
hi("@markup.raw.inline", { fg = c.green })
hi("@markup.raw.block", { fg = c.aqua })

-- ---- diagnostics (helix severity colors + underline curls) ----
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })
hi("DiagnosticVirtualTextError", { fg = c.red })
hi("DiagnosticVirtualTextWarn", { fg = c.yellow })
hi("DiagnosticVirtualTextInfo", { fg = c.blue })
hi("DiagnosticVirtualTextHint", { fg = c.green })
hi("DiagnosticFloatingError", { fg = c.red })
hi("DiagnosticFloatingWarn", { fg = c.yellow })
hi("DiagnosticFloatingInfo", { fg = c.blue })
hi("DiagnosticFloatingHint", { fg = c.green })
hi("DiagnosticUnnecessary", { fg = c.grey0 })
hi("DiagnosticDeprecated", { strikethrough = true })

-- ---- LSP ----
hi("LspReferenceText", { bg = c.bg_visual })
hi("LspReferenceRead", { bg = c.bg_visual })
hi("LspReferenceWrite", { bg = c.bg_visual })
hi("LspInlayHint", { link = "InlayHint" })
hi("InlayHint", { fg = c.grey0, italic = true })
hi("LspSignatureActiveParameter", { bg = c.bg3 })

-- ---- diff / git (helix diff.* + gutter decorations) ----
hi("DiffAdd", { fg = c.green, bg = c.bg_green })
hi("DiffChange", { fg = c.blue, bg = c.bg_blue })
hi("DiffDelete", { fg = c.red, bg = c.bg_red })
hi("DiffText", { fg = c.blue, bg = c.bg_blue, bold = true })
hi("Added", { fg = c.green })
hi("Changed", { fg = c.blue })
hi("Removed", { fg = c.red })
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.blue })
hi("GitSignsDelete", { fg = c.red })
hi("GitSignsTopdelete", { fg = c.red })
hi("GitSignsChangedelete", { fg = c.blue })
hi("GitSignsUntracked", { fg = c.grey0 })

-- ---- spelling ----
hi("SpellBad", { undercurl = true, sp = c.red })
hi("SpellCap", { undercurl = true, sp = c.blue })
hi("SpellRare", { undercurl = true, sp = c.purple })
hi("SpellLocal", { undercurl = true, sp = c.aqua })
