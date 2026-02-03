# Custom Neovim Themes

This directory is for storing custom Neovim colorscheme files (.vim or .lua).

## Built-in Themes

The main Neovim config (in `nvim/lua/plugins/colorscheme.lua`) uses lazy.nvim to install popular themes:

- **Catppuccin** (default) - Modern pastel theme
- **Tokyo Night** - Dark theme inspired by Tokyo's night
- **Rose Pine** - Soho vibes for Neovim

These are automatically installed and don't need to be placed here.

## Adding Custom Themes

If you have a custom colorscheme or want to add themes not managed by lazy.nvim:

1. Drop your theme file here:
   - `themes/nvim/mytheme.vim` (Vimscript theme)
   - `themes/nvim/mytheme.lua` (Lua theme)

2. Make Neovim aware of this directory by adding to `nvim/init.lua`:
   ```lua
   vim.opt.runtimepath:append("~/projects/dotClaude/themes/nvim")
   ```

3. In Neovim, activate with:
   ```vim
   :colorscheme mytheme
   ```

4. To make permanent, edit `nvim/lua/plugins/colorscheme.lua`:
   ```lua
   vim.cmd.colorscheme("mytheme")
   ```

## Why This Directory Exists

Most users won't need this directory. It exists for:

- Custom colorschemes created by you
- Themes not available as plugins
- Local theme development/testing
- Offline colorscheme storage

## Recommended Approach

Instead of using this directory, prefer installing themes via lazy.nvim in `nvim/lua/plugins/colorscheme.lua`:

```lua
return {
  -- ... existing themes
  {
    "author/theme-name",
    priority = 1000,
  },
}
```

This ensures themes are automatically installed on any machine.
