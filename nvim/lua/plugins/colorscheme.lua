return {
  -- Load Phthalo theme (custom theme in colors/ directory)
  {
    "phthalo-theme",
    dir = vim.fn.stdpath("config") .. "/colors",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("phthalo")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 999,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night", -- storm, moon, night, day
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "main", -- auto, main, moon, dawn
      dark_variant = "main",
    },
  },
}
