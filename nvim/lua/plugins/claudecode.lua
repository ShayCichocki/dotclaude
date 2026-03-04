return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        -- Window configuration - larger size for better visibility
        window = {
          split_ratio = 0.5,           -- 50% of screen for terminal
          position = "botright",        -- Bottom-right split
          enter_insert = true,          -- Enter insert mode on open
          hide_numbers = false,         -- Show line numbers
          hide_signcolumn = false,      -- Show sign column
        },
        -- File refresh settings - ensures left pane updates after accepting edits
        refresh = {
          enable = true,                -- Enable file change detection
          updatetime = 100,             -- Check for updates every 100ms
          timer_interval = 1000,        -- File change check interval
          show_notifications = false,   -- Don't spam notifications
        },
        -- Git integration
        git = {
          use_git_root = true,          -- Use git root as working directory
          multi_instance = false,       -- Single Claude instance
        },
      })
    end,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>aR", "<cmd>ClaudeCodeResume<cr>", desc = "Resume conversation" },
      { "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "Continue last conversation" },
    },
  },
}
