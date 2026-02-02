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
# Neovim Theme Check
# ─────────────────────────────────────────────────────────────

step "Checking Neovim themes..."

if [[ -d "$HOME/.config/nvim/colors" ]]; then
    info "  Found nvim themes:"
    ls -1 "$HOME/.config/nvim/colors" 2>/dev/null | while read -r theme; do
        echo "    - $theme"
    done

    # Copy themes to this repo for backup
    mkdir -p "$SCRIPT_DIR/themes/nvim"
    cp "$HOME/.config/nvim/colors/"* "$SCRIPT_DIR/themes/nvim/" 2>/dev/null || true
    info "  Copied nvim themes to themes/nvim/"
else
    warn "  No nvim themes found at ~/.config/nvim/colors"
fi

# ─────────────────────────────────────────────────────────────
# Backup existing ~/.claude
# ─────────────────────────────────────────────────────────────

step "Setting up ~/.claude..."

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

# ─────────────────────────────────────────────────────────────
# Done
# ─────────────────────────────────────────────────────────────

step "Setup complete!"

echo ""
echo "Your ~/.claude is now configured with:"
echo "  - Homebrew package manager"
echo "  - Node.js + npm"
echo "  - Claude Code CLI"
echo "  - commands/ (alphie, onboard, review, etc.)"
echo "  - skills/ (review-*, paul-graham, etc.)"
echo "  - Get Shit Done workflow system"
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start a session"
echo "  2. Run '/gsd:help' to see GSD commands"
echo ""
info "Happy hacking!"
