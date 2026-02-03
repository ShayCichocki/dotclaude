# Neovim Configuration

Comprehensive, portable Neovim configuration for dotClaude.

## Features

- **LSP Support**: TypeScript, Go, Rust, Python, Lua, Bash, JSON, YAML
- **Automatic Installation**: Mason auto-installs LSP servers on first launch
- **Autocompletion**: nvim-cmp with LSP, snippets, buffer, and path sources
- **Fuzzy Finding**: Telescope for files, grep, buffers, and more
- **Git Integration**: Gitsigns (inline git changes) + Fugitive (git commands)
- **Claude Code Integration**: Preserved existing integration with keybindings
- **Multiple Themes**: Catppuccin (default), Tokyo Night, Rose Pine
- **Treesitter**: Advanced syntax highlighting and code understanding
- **Quality of Life**: Auto-pairs, commenting, which-key, statusline

## Installation

### Automatic (Recommended)

Run the dotClaude setup script:

```bash
cd ~/projects/dotClaude
./setup.sh
```

This will:
- Backup existing `~/.config/nvim` to `~/.config/nvim.backup.<timestamp>`
- Create symlink `~/.config/nvim` → `~/projects/dotClaude/nvim`
- Neovim will auto-install plugins on first launch

### Manual Installation

```bash
ln -s ~/projects/dotClaude/nvim ~/.config/nvim
```

## First Launch

On first `nvim` launch:

1. **Lazy.nvim** will install all plugins (~30 seconds)
2. **Mason** will install LSP servers (~1-2 minutes)
3. **Treesitter** will install parsers (~30 seconds)

You'll see installation progress at the bottom of the screen. Let it complete before opening files.

## Keybindings

### Leader Key

`<leader>` = `Space`

### General Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate between windows |
| `<S-h>` / `<S-l>` | Previous/next buffer |
| `<C-s>` | Save file (insert + normal mode) |
| `<Esc>` | Clear search highlight |
| `<C-d>` / `<C-u>` | Scroll down/up (centered) |

### File Finding (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Browse buffers |
| `<leader>fh` | Help tags |
| `<leader>fo` | Recent files |
| `<leader>fw` | Find word under cursor |
| `<leader>fk` | Keymaps |

### LSP (when attached to buffer)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format file |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Diagnostic list |

### Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude Code |
| `<leader>af` | Focus Claude Code |
| `<leader>as` | Send selection to Claude (visual mode) |

### Git

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/previous git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>gs` | Git status (fugitive) |
| `<leader>gc` | Git commit (fugitive) |
| `<leader>gd` | Git diff (fugitive) |

### Editor

| Key | Action |
|-----|--------|
| `gcc` | Comment line (normal mode) |
| `gc` | Comment selection (visual mode) |
| `<` / `>` | Indent left/right (visual mode, keeps selection) |
| `J` / `K` | Move text down/up (visual mode) |

## Customization

### Change Theme

Edit `nvim/lua/plugins/colorscheme.lua`:

```lua
-- Line 30, change to:
vim.cmd.colorscheme("tokyonight")  -- or "rose-pine"
```

Or change interactively in Neovim:

```vim
:colorscheme tokyonight
:colorscheme rose-pine
```

### Add LSP Server

1. Find the server name at [mason-lspconfig servers](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md)
2. Edit `nvim/lua/plugins/lsp.lua`, add to `ensure_installed`:

```lua
ensure_installed = {
  -- ... existing servers
  "clangd",  -- for C/C++
  "html",    -- for HTML
},
```

3. Add configuration in `nvim/lua/utils/lsp-servers.lua`:

```lua
-- C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
})
```

### Modify Vim Options

Edit `nvim/lua/config/options.lua`:

```lua
opt.relativenumber = false  -- Disable relative line numbers
opt.wrap = true             -- Enable line wrap
opt.colorcolumn = "80"      -- Change ruler column
```

### Add Keybindings

Edit `nvim/lua/config/keymaps.lua`:

```lua
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
```

### Disable Plugin Group

Comment out the return statement in the respective plugin file:

```lua
-- nvim/lua/plugins/git.lua
-- return { ... }  -- disable all git plugins
return {}
```

Or remove specific plugins from the return table.

## Troubleshooting

### LSP not working

1. Check if LSP server is attached: `:LspInfo`
2. Check Mason installation: `:Mason` (look for green checkmarks)
3. Check Mason logs: `:MasonLog`
4. Manually install server: `:MasonInstall ts_ls`

### Plugins not installing

1. Check network connection
2. View plugin status: `:Lazy`
3. Retry installation: `:Lazy sync`
4. Clear cache and reinstall: `:Lazy clean` then `:Lazy sync`

### Treesitter errors

1. Manually install parser: `:TSInstall <language>`
2. Check health: `:checkhealth nvim-treesitter`
3. Update all parsers: `:TSUpdate`

### Completion not working

1. Check LSP is attached: `:LspInfo`
2. Check completion sources loaded: `:lua print(vim.inspect(require('cmp').get_config().sources))`
3. Restart Neovim

### Performance issues

1. Check startup time: `nvim --startuptime startup.log`
2. Disable unused plugins (see "Disable Plugin Group" above)
3. Reduce Treesitter parsers in `nvim/lua/plugins/treesitter.lua`

## Project Structure

```
nvim/
├── init.lua                   # Entry point
├── README.md                  # This file
└── lua/
    ├── config/
    │   ├── lazy.lua          # Plugin manager bootstrap
    │   ├── options.lua       # Vim options
    │   ├── keymaps.lua       # General keybindings
    │   └── autocmds.lua      # Autocommands
    ├── plugins/
    │   ├── claudecode.lua    # Claude Code integration
    │   ├── colorscheme.lua   # Themes
    │   ├── lsp.lua           # Mason + LSP setup
    │   ├── completion.lua    # nvim-cmp
    │   ├── treesitter.lua    # Syntax highlighting
    │   ├── telescope.lua     # Fuzzy finder
    │   ├── editor.lua        # Editing plugins
    │   ├── ui.lua            # Statusline, icons
    │   ├── git.lua           # Git integration
    │   └── schemastore.lua   # JSON/YAML schemas
    └── utils/
        └── lsp-servers.lua   # LSP server configs
```

## Learning Resources

- **Neovim Basics**: `:Tutor` (in Neovim)
- **LSP Commands**: `:h lsp`
- **Telescope**: `:h telescope.nvim`
- **Treesitter**: `:h nvim-treesitter`
- **Plugin Config**: Read the plugin files in `lua/plugins/`

## Tips

- **Which-key**: Press `<leader>` and wait to see available keybindings
- **Hover Help**: Press `K` over any symbol to see documentation
- **Go Back**: Press `<C-o>` after `gd` (go to definition) to return
- **Format on Save**: `:autocmd BufWritePre * lua vim.lsp.buf.format()`
- **Terminal**: `:terminal` to open terminal in split

## Updating

To update all plugins:

```vim
:Lazy sync
```

To update LSP servers:

```vim
:MasonUpdate
```

## Portable Setup

This configuration is designed to be portable:

1. All plugins managed by lazy.nvim (auto-installed)
2. All LSP servers managed by Mason (auto-installed)
3. No hard-coded paths or machine-specific settings
4. Works identically on any machine after `./setup.sh`

Just clone dotClaude on a new machine and run `./setup.sh`!
