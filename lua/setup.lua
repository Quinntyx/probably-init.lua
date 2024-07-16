vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local utils = require('utils')
local knobs = utils.knobs()

assert(knobs ~= nil)

if knobs.lsp == nil then
    vim.notify("Malformed knobs.lua; missing lsp configuration")
end
if knobs.git == nil then
    vim.notify("Malformed knobs.lua  missing git configuration")
end
if knobs.graphics == nil then
    vim.notify("Malformed knobs.lua; missing graphics configuration")
end
if knobs.remote == nil then
    vim.notify("Malformed knobs.lua; missing remote configuration")
end
if knobs.colorscheme == nil then
    vim.notify("Malformed knobs.lua; missing colorscheme configuration")
end
if knobs.codesnap == nil then
    vim.notify("Malformed knobs.lua; missing codesnap configuration")
end
if knobs.firenvim == nil then
    vim.notify("Malformed knobs.lua; missing firenvim configuration")
end
if knobs.neorg == nil then
    vim.notify("Malformed knobs.lua; missing neorg configuration")
end

require("lazy").setup({
    { import = "load.core" },
    { import = "load.dev" },
    knobs.lsp.enabled and { import = "load.lsp" } or {},
    knobs.git.enabled and { import = "load.git" } or {},
    knobs.graphics.enabled and { import = "load.graphics" } or {},
    knobs.remote.enabled and { import = "load.remote" } or {},
    knobs.colorscheme.enabled and { import = "load.colorscheme" } or {},
    knobs.codesnap.enabled and { import = "load.codesnap" } or {},
    knobs.firenvim.enabled and { import = "load.firenvim" } or {},
    knobs.neorg.enabled and { import = "load.neorg" } or {},
})
