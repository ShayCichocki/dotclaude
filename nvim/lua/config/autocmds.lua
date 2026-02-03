-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  group = vim.api.nvim_create_augroup("trim-whitespace", { clear = true }),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Terminal settings
autocmd("TermOpen", {
  desc = "Terminal settings",
  group = vim.api.nvim_create_augroup("terminal-settings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- Close certain filetypes with q
autocmd("FileType", {
  desc = "Close with q",
  group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
  pattern = { "help", "lspinfo", "man", "qf" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf })
  end,
})
