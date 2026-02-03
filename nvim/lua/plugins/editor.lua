return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = "v", desc = "Comment selection" },
      { "gbc", mode = "n", desc = "Comment block" },
      { "gb", mode = "v", desc = "Comment block selection" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["<leader>f"] = { name = "+find" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>a"] = { name = "+ai" },
      })
    end,
  },
}
