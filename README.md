# dotclaude

A curated `.claude` configuration directory that extends Claude Code with custom commands, skills, and workflow automation for software development.

## What is this?

This repository provides a pre-configured Claude Code environment optimized for professional software development workflows. It includes:

- **Portable Neovim Configuration** with LSP, completion, fuzzy finding, and Claude Code integration
- **Custom Commands** for workflow automation (onboarding, epic orchestration, code review)
- **Code Review Skills** specialized for different quality dimensions
- **Integration with `prog`** for cross-session task management

## Installation

### Automated Setup (Recommended)

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/projects/dotClaude
   cd ~/projects/dotClaude
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

   This will:
   - Install Homebrew (if not present)
   - Install Node.js and npm
   - Install Claude Code CLI
   - Setup Neovim configuration (symlink `~/.config/nvim`)
   - Copy commands and skills to `~/.claude`
   - Install Get Shit Done workflow system

3. Start using Claude Code:
   ```bash
   claude
   ```

### Manual Installation

If you prefer manual setup or already have some components:

1. Clone the repository:
   ```bash
   git clone <your-repo-url> ~/projects/dotClaude
   ```

2. Link Neovim configuration:
   ```bash
   ln -s ~/projects/dotClaude/nvim ~/.config/nvim
   ```

3. Link Claude Code configuration:
   ```bash
   # Option 1: Symlink to your project
   ln -s ~/projects/dotClaude /path/to/your/project/.claude

   # Option 2: Copy to global ~/.claude
   cp -r ~/projects/dotClaude/commands ~/.claude/
   cp -r ~/projects/dotClaude/skills ~/.claude/
   cp ~/projects/dotClaude/CLAUDE.md ~/.claude/
   ```

4. Install dependencies:
   ```bash
   # Install Claude Code CLI
   npm install -g @anthropic-ai/claude-code

   # Install Get Shit Done
   npx get-shit-done-cc --claude --global
   ```

## Custom Commands

### `/onboard`

Load project context and prepare for a development session.

```bash
# Interactive mode - choose what to work on
/onboard

# Autopilot mode - auto-select top ready task
/onboard --auto
```

**What it does:**
- Syncs git branch with main
- Installs/updates dependencies
- Loads project context from CLAUDE.md, AGENTS.md
- Fetches current work from prog
- Presents recommended tasks or auto-selects in autopilot mode

### `/alphie <EPIC_ID>`

Execute a prog epic by spawning parallel task workers.

```bash
# Run an epic with default settings
/alphie ep-a1b2c3

# Custom concurrency and branch
/alphie ep-a1b2c3 --agents 2 --base-branch develop

# Dry run to see execution plan
/alphie ep-a1b2c3 --dry-run
```

**What it does:**
- Loads epic and all child tasks from prog
- Analyzes dependencies and file conflicts
- Creates parallelization plan (batched by conflicts)
- Spawns worker agents for each task in isolated worktrees
- Monitors completion and spawns next unblocked tasks
- Provides final summary of completed work

### `/ralphie`

Task worker agent (typically spawned by Alphie, but can be used standalone).

**What it does:**
- Claims and executes a single task
- Loads relevant context from prog memory
- Works in isolated git worktree
- Runs verification (tests, lint, build)
- Merges to base branch
- Captures learnings for future agents

### `/review`

Run comprehensive code review checks.

**What it does:**
- Executes multiple specialized review skills
- Checks architecture, readability, security, simplicity
- Provides structured feedback with severity levels
- Generates actionable recommendations

## Custom Skills

All skills in the `skills/` directory are available for individual use:

- `review-architecture` - Architectural patterns and structure review
- `review-readability` - Code clarity and maintainability review
- `review-security` - Security vulnerability and best practices review
- `review-simplicity` - Over-engineering and unnecessary complexity review
- `design-principles` - Core design principles and guidelines
- `remove-slop` - Remove AI-generated fluff and verbose patterns

## Prog Integration

This configuration assumes you're using `prog` for task management. Key commands:

```bash
# View current state
prog status
prog ready

# Start work on a task
prog show <task-id>
prog start <task-id>

# Track progress
prog log <task-id> "Implemented feature X"
prog done <task-id>

# Load relevant context
prog context -c <concept>
prog context -q "search terms"

# Capture learnings
prog learn "insight" -c concept
```

See the startup hook message for the complete prog workflow reference.

## Neovim Configuration

This repository includes a comprehensive, portable Neovim configuration with:

- **LSP Support**: TypeScript, Go, Rust, Python, Lua, Bash, JSON, YAML
- **Auto-install**: Mason automatically installs LSP servers on first launch
- **Completion**: nvim-cmp with LSP, snippets, buffer, and path sources
- **Fuzzy Finding**: Telescope for files and grep
- **Git Integration**: Gitsigns + Fugitive
- **Claude Code Integration**: Preserved existing keybindings
- **Themes**: Catppuccin, Tokyo Night, Rose Pine

See [nvim/README.md](nvim/README.md) for detailed documentation.

### Quick Start

After running `./setup.sh`, launch Neovim:

```bash
nvim
```

On first launch, plugins and LSP servers will auto-install (~2-3 minutes).

### Key Keybindings

- `<leader>` = Space
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>ac` - Toggle Claude Code
- `<leader>as` - Send selection to Claude (visual mode)

## Project Structure

```
dotClaude/
├── nvim/                  # Neovim configuration
│   ├── init.lua          # Entry point
│   ├── README.md         # Neovim documentation
│   └── lua/
│       ├── config/       # Core config (options, keymaps)
│       ├── plugins/      # Plugin configurations
│       └── utils/        # LSP server configs
├── commands/             # Custom workflow commands
│   ├── onboard.md       # Session initialization
│   └── review.md        # Code review automation
├── skills/              # Specialized code review skills
│   ├── review-architecture/
│   ├── review-readability/
│   ├── review-security/
│   ├── review-simplicity/
│   ├── design-principles/
│   └── remove-slop/
├── themes/              # Custom theme storage
│   └── nvim/           # Custom Neovim colorschemes
├── .claude/            # Claude Code settings
├── setup.sh            # Automated setup script
├── CLAUDE.md           # Agent instructions
└── README.md
```

## Workflow Example

Typical development session:

1. **Start session:**
   ```bash
   claude
   /onboard
   ```

2. **Claude loads context and presents options:**
   - Shows current work in progress
   - Recommends next tasks based on dependencies
   - You choose what to work on

3. **Work on task:**
   - Claude has full task spec and relevant context loaded
   - Implement, test, iterate

4. **Review before completing:**
   ```bash
   /review
   ```

5. **Complete task:**
   - Prog automatically updated throughout
   - Learnings captured for future sessions

6. **Execute an epic:**
   ```bash
   /alphie ep-xyz123
   ```
   - Spawns multiple workers in parallel
   - Each works in isolated worktree
   - All coordinate through prog

## Requirements

- **Neovim** 0.9+ (for nvim configuration)
- **Claude Code CLI** (installed by setup.sh)
- **Node.js** 18+ and npm (installed by setup.sh via Homebrew)
- **Git** (for worktree management and version control)
- **Homebrew** (macOS/Linux, installed by setup.sh)

Optional:
- **prog** CLI tool (for task management integration)
- Project-specific: tests, linters, build tools mentioned in task specs

## Platform Support

- **macOS**: Full support via setup.sh
- **Linux**: Full support via setup.sh
- **Windows**: Manual installation required (WSL recommended)
