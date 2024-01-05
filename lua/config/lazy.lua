local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  { import = "plugins.coding" },
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  -- { import = "plugins.tools" },
  -- { import = "plugins" },
}, {
  defaults = {
    lazy = true,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false, notify = false }, -- automatically check for plugin updates
  ui = {
    border = "rounded",
  },
  dev = {
    path = "~/projects",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "tohtml",
        "man",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
      },
    },
  },
})

require("config.keymaps")
require("config.options")
require("config.autocmds")
