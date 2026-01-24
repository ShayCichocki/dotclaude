# dotclaude

A curated `.claude` configuration directory that extends Claude Code with custom commands, skills, and workflow automation for software development.

## What is this?

This repository provides a pre-configured Claude Code environment optimized for professional software development workflows. It includes:

- **Custom Commands** for workflow automation (onboarding, epic orchestration, code review)
- **Code Review Skills** specialized for different quality dimensions
- **Integration with `prog`** for cross-session task management

## Installation

1. Clone this repository to your preferred location:
   ```bash
   git clone <your-repo-url> ~/dotclaude
   ```

2. Link it as your `.claude` configuration directory:
   ```bash
   # Option 1: Symlink to your project
   ln -s ~/dotclaude /path/to/your/project/.claude

   # Option 2: Set as global default (if supported by Claude Code)
   # Check Claude Code documentation for global config options
   ```

3. Ensure `prog` CLI is installed and initialized:
   ```bash
   # Install prog (check prog documentation for installation)
   # Initialize the database
   prog init
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

## Project Structure

```
dotclaude/
├── commands/          # Custom workflow commands
│   ├── alphie.md     # Epic orchestrator
│   ├── ralphie.md    # Task worker
│   ├── onboard.md    # Session initialization
│   └── review.md     # Code review automation
├── skills/           # Specialized code review skills
│   ├── review-architecture/
│   ├── review-readability/
│   ├── review-security/
│   ├── review-simplicity/
│   ├── design-principles/
│   └── remove-slop/
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

- Claude Code CLI
- `prog` CLI tool (for task management)
- Git (for worktree management in alphie/ralphie)
- Project-specific: tests, linters, build tools mentioned in task specs
