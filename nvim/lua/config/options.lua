-- Vim options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.colorcolumn = "100"

-- Behavior
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Backspace
opt.backspace = "indent,eol,start"

-- Wrap
opt.wrap = false
