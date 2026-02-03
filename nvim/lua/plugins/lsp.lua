return {
  {
    "williamboman/mason.nvim",
    config = true,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",         -- TypeScript/JavaScript
        "gopls",         -- Go
        "rust_analyzer", -- Rust
        "pyright",       -- Python
        "lua_ls",        -- Lua
        "bashls",        -- Bash
        "jsonls",        -- JSON
        "yamlls",        -- YAML
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Setup LSP servers
      require("utils.lsp-servers").setup()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}
