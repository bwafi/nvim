return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers", -- get the correct treesitter norg parser
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  version = "*", -- Pin Neorg to the latest stable release
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
      ["core.integrations.nvim-cmp"] = {},
      ["core.itero"] = {},
      ["core.concealer"] = { config = { icon_preset = "diamond" } },
      ["core.keybinds"] = {
        -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
        config = {
          default_keybinds = true,
          -- neorg_leader = "<Leader><Leader>",
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Notes/",
          },
          default_workspace = "notes",
        },
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {
        config = {
          extensions = "all",
        },
      },
    },
  },
}
