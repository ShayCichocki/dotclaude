#!/usr/bin/env bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
step() { echo -e "\n${BLUE}==>${NC} $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# ─────────────────────────────────────────────────────────────
# Helper Functions
# ─────────────────────────────────────────────────────────────

has_cmd() {
    command -v "$1" &> /dev/null
}

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        *)       echo "unknown" ;;
    esac
}

OS=$(detect_os)
info "Detected OS: $OS"

# ─────────────────────────────────────────────────────────────
# Install Homebrew (macOS/Linux)
# ─────────────────────────────────────────────────────────────

step "Checking Homebrew..."

if has_cmd brew; then
    info "  ✓ Homebrew already installed"
else
    info "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for this session
    if [[ "$OS" == "linux" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ "$OS" == "macos" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
    fi

    # Persist brew to shell config
    info "  Configuring shell environment..."

    # Detect shell and config file
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash)
            SHELL_CONFIG="$HOME/.bashrc"
            ;;
        zsh)
            SHELL_CONFIG="$HOME/.zshrc"
            ;;
        *)
            SHELL_CONFIG="$HOME/.profile"
            ;;
    esac

    # Add brew shellenv to config if not already present
    BREW_INIT_LINE='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
    if [[ "$OS" == "macos" ]]; then
        BREW_INIT_LINE='eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"'
    fi

    if ! grep -q "brew shellenv" "$SHELL_CONFIG" 2>/dev/null; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Homebrew" >> "$SHELL_CONFIG"
        echo "$BREW_INIT_LINE" >> "$SHELL_CONFIG"
        info "  ✓ Added Homebrew to $SHELL_CONFIG"
    else
        info "  ✓ Homebrew already in $SHELL_CONFIG"
    fi

    # Install build dependencies on Linux
    if [[ "$OS" == "linux" ]]; then
        info "  Checking build dependencies..."
        if command -v sudo &> /dev/null; then
            if ! dpkg -l | grep -q build-essential 2>/dev/null; then
                info "  Installing build-essential..."
                sudo apt-get update -qq
                sudo apt-get install -y build-essential
                info "  ✓ build-essential installed"
            else
                info "  ✓ build-essential already installed"
            fi
        else
            warn "  sudo not available, skipping build-essential"
        fi
    fi

    # Install GCC (recommended by Homebrew)
    info "  Checking GCC..."
    if brew list gcc &>/dev/null; then
        info "  ✓ GCC already installed"
    else
        info "  Installing GCC (recommended by Homebrew)..."
        brew install gcc
        info "  ✓ GCC installed"
    fi

    info "  ✓ Homebrew installed and configured"
fi

# ─────────────────────────────────────────────────────────────
# Install Core Dependencies via Brew
# ─────────────────────────────────────────────────────────────

step "Checking core dependencies..."

install_if_missing() {
    local cmd=$1
    local pkg=${2:-$1}  # package name defaults to command name

    if has_cmd "$cmd"; then
        info "  ✓ $cmd already installed"
    else
        info "  Installing $pkg..."
        brew install "$pkg"
        info "  ✓ $pkg installed"
    fi
}

install_if_missing "git"
install_if_missing "node"
install_if_missing "npm" "node"  # npm comes with node
install_if_missing "go" "go"
install_if_missing "jq" "jq"  # For JSON merging

# ─────────────────────────────────────────────────────────────
# Install Optional Tools
# ─────────────────────────────────────────────────────────────

step "Checking optional tools..."

install_optional() {
    local cmd=$1
    local pkg=${2:-$1}

    if has_cmd "$cmd"; then
        info "  ✓ $cmd already installed"
    else
        printf "  Install $pkg? [y/N] "
        read -r REPLY
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install "$pkg"
            info "  ✓ $pkg installed"
        else
            warn "  Skipped $pkg"
        fi
    fi
}

install_optional "nvim" "neovim"

# ─────────────────────────────────────────────────────────────
# Install Claude Code CLI
# ─────────────────────────────────────────────────────────────

step "Checking Claude Code CLI..."

if has_cmd claude; then
    info "  ✓ Claude Code already installed"
else
    info "  Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
    info "  ✓ Claude Code installed"
fi

# ─────────────────────────────────────────────────────────────
# Neovim Theme Setup
# ─────────────────────────────────────────────────────────────

step "Setting up Neovim themes..."

# Backup existing themes from current nvim config
if [[ -d "$HOME/.config/nvim/colors" ]]; then
    info "  Found existing nvim themes:"
    ls -1 "$HOME/.config/nvim/colors" 2>/dev/null | while read -r theme; do
        echo "    - $theme"
    done

    # Copy themes to this repo for backup
    mkdir -p "$SCRIPT_DIR/themes/nvim"
    cp "$HOME/.config/nvim/colors/"* "$SCRIPT_DIR/themes/nvim/" 2>/dev/null || true
    info "  Backed up nvim themes to themes/nvim/"
fi

# Copy custom themes from repo to nvim config
if [[ -d "$SCRIPT_DIR/themes/nvim" ]]; then
    # Count actual theme files (not README or .gitkeep)
    THEME_COUNT=$(find "$SCRIPT_DIR/themes/nvim" -type f \( -name "*.vim" -o -name "*.lua" \) 2>/dev/null | wc -l)

    if [[ $THEME_COUNT -gt 0 ]]; then
        mkdir -p "$SCRIPT_DIR/nvim/colors"
        cp "$SCRIPT_DIR/themes/nvim/"*.{vim,lua} "$SCRIPT_DIR/nvim/colors/" 2>/dev/null || true
        info "  ✓ Copied $THEME_COUNT custom theme(s) to nvim/colors/"
    else
        info "  No custom themes found in themes/nvim/ (only .vim or .lua files are copied)"
    fi
fi

# ─────────────────────────────────────────────────────────────
# Setup Neovim Configuration
# ─────────────────────────────────────────────────────────────

step "Setting up Neovim configuration..."

if has_cmd nvim; then
    # Check if ~/.config/nvim exists
    if [[ -d "$HOME/.config/nvim" ]] || [[ -L "$HOME/.config/nvim" ]]; then
        # Check if it's already our symlink
        if [[ -L "$HOME/.config/nvim" ]] && [[ "$(readlink "$HOME/.config/nvim")" == "$SCRIPT_DIR/nvim" ]]; then
            info "  ✓ Neovim config already symlinked to dotClaude/nvim"
        else
            # Backup existing config
            NVIM_BACKUP="$HOME/.config/nvim.backup.$(date +%s)"
            warn "  Backing up existing ~/.config/nvim to $NVIM_BACKUP"
            if [[ -L "$HOME/.config/nvim" ]]; then
                rm "$HOME/.config/nvim"
            else
                mv "$HOME/.config/nvim" "$NVIM_BACKUP"
            fi

            # Create symlink
            ln -s "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
            info "  ✓ Linked $SCRIPT_DIR/nvim to ~/.config/nvim"
            info "  Neovim will install plugins on first launch"
        fi
    else
        # No existing config, just symlink
        mkdir -p "$HOME/.config"
        ln -s "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
        info "  ✓ Linked $SCRIPT_DIR/nvim to ~/.config/nvim"
        info "  Neovim will install plugins on first launch"
    fi
else
    warn "  Neovim not installed, skipping config setup"
    warn "  Install neovim and run setup.sh again to configure"
fi

# ─────────────────────────────────────────────────────────────
# Backup existing ~/.claude
# ─────────────────────────────────────────────────────────────

step "Setting up ~/.claude..."

# Save settings.json FIRST before nuking anything
SETTINGS_BACKUP=""
if [[ -f "$HOME/.claude/settings.json" ]]; then
    SETTINGS_BACKUP="/tmp/.claude.settings.backup.$(date +%s).json"
    cp "$HOME/.claude/settings.json" "$SETTINGS_BACKUP"
    info "  Saved existing settings.json to temp location"
fi

if [[ -d "$HOME/.claude" ]]; then
    if [[ -L "$HOME/.claude" ]]; then
        info "  ~/.claude is already a symlink, removing..."
        rm "$HOME/.claude"
    else
        BACKUP_DIR="$HOME/.claude.backup.$(date +%s)"
        warn "  Backing up existing ~/.claude to $BACKUP_DIR"
        mv "$HOME/.claude" "$BACKUP_DIR"
    fi
fi

# ─────────────────────────────────────────────────────────────
# Setup .claude directory
# ─────────────────────────────────────────────────────────────

info "  Creating ~/.claude directory..."
mkdir -p "$HOME/.claude"

# Copy our config files
info "  Copying config files..."
cp -r "$SCRIPT_DIR/commands" "$HOME/.claude/" 2>/dev/null || true
cp -r "$SCRIPT_DIR/skills" "$HOME/.claude/" 2>/dev/null || true
cp "$SCRIPT_DIR/.claude/settings.local.json" "$HOME/.claude/" 2>/dev/null || true

# Symlink CLAUDE.md to home for global use
if [[ -f "$SCRIPT_DIR/CLAUDE.md" ]]; then
    ln -sf "$SCRIPT_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
    info "  ✓ Linked CLAUDE.md"
fi

# ─────────────────────────────────────────────────────────────
# Install Get Shit Done
# ─────────────────────────────────────────────────────────────

step "Installing Get Shit Done..."

npx get-shit-done-cc --claude --global

info "  ✓ GSD installed!"

# Merge settings.json if we had a backup from earlier
if [[ -n "$SETTINGS_BACKUP" ]] && [[ -f "$SETTINGS_BACKUP" ]]; then
    step "Merging settings.json..."

    if [[ -f "$HOME/.claude/settings.json" ]]; then
        # Merge: old settings take precedence for existing keys, new settings add their keys
        MERGED=$(jq -s '.[1] * .[0]' "$SETTINGS_BACKUP" "$HOME/.claude/settings.json" 2>/dev/null)
        if [[ $? -eq 0 ]] && [[ -n "$MERGED" ]]; then
            echo "$MERGED" > "$HOME/.claude/settings.json"
            info "  ✓ Merged existing settings with new GSD settings"
            info "  Your original settings were preserved, GSD added its settings"
        else
            warn "  Failed to merge settings, keeping new GSD settings"
        fi
    else
        # GSD didn't create settings.json, just restore the backup
        cp "$SETTINGS_BACKUP" "$HOME/.claude/settings.json"
        info "  ✓ Restored your original settings.json"
    fi

    # Clean up temp backup
    rm "$SETTINGS_BACKUP"
fi

# ─────────────────────────────────────────────────────────────
# Done
# ─────────────────────────────────────────────────────────────

step "Setup complete!"

echo ""
echo "Your ~/.claude is now configured with:"
echo "  - Homebrew package manager"
echo "  - Node.js + npm"
echo "  - Claude Code CLI"
echo "  - Neovim configuration (symlinked to ~/.config/nvim)"
echo "  - commands/ (alphie, onboard, review, etc.)"
echo "  - skills/ (review-*, paul-graham, etc.)"
echo "  - Get Shit Done workflow system"
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start a session"
echo "  2. Run '/gsd:help' to see GSD commands"
echo ""
info "Happy hacking!"
