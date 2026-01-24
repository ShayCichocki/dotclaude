# CLAUDE.md

Documentation for Claude Code agents working in projects using this `.claude` configuration.

## Overview

This project uses a customized Claude Code environment with:
- **prog** for cross-session task management
- **Custom commands** for workflow automation (/onboard, /alphie, /review)
- **Specialized skills** for code review and quality checks
- **Startup hooks** that provide prog context on session start

## Core Principles

1. **Context-aware:** Always load relevant context before starting work
2. **Task-driven:** Work flows through prog tasks with clear specs
3. **Memory-enabled:** Learnings persist across sessions via prog
4. **Quality-focused:** Multiple review dimensions before completion
5. **Parallel-capable:** Alphie can orchestrate multiple workers safely

## Session Workflow

### Starting a Session

When a human runs `claude`, the startup hook automatically provides prog context. You should:

1. **Understand current state:**
   - Check prog status (shown in startup hook)
   - Use `/onboard` to load full context and choose work

2. **Load task context:**
   - If continuing existing work, task details will be loaded
   - If starting new task, prog will provide full spec

3. **Load relevant learnings:**
   ```bash
   # Use concepts suggested by the task
   prog context -c <concept> --summary  # Scan first
   prog context --id <lrn-id>           # Load specific learning

   # Or search by keywords
   prog context -q "error handling"
   ```

### During Work

1. **Follow the spec:**
   - Task description is the source of truth
   - Don't expand scope beyond what's specified
   - Ask questions if spec is unclear

2. **Log progress:**
   ```bash
   prog log <task-id> "Implemented X"
   prog log <task-id> "Added tests for Y"
   ```
   Log meaningful milestones, not spam.

3. **Stay focused:**
   - Solve today's problem today (YAGNI)
   - Avoid over-engineering
   - No premature abstraction
   - Keep changes minimal and focused

### Before Completing

1. **Verify:**
   - Run all required tests
   - Run linters and type checks
   - Run any verification steps from task spec
   - Do NOT mark complete if verification fails

2. **Review:**
   - Use `/review` for comprehensive quality checks
   - Address blockers and warnings
   - Consider notes for improvements

3. **Complete:**
   ```bash
   prog done <task-id>
   ```
   Only when:
   - Tests pass
   - Code reviewed
   - Changes merged or PR created
   - Verification complete

### Ending a Session

**CRITICAL:** Never end a session without updating prog. Follow the SESSION CLOSE PROTOCOL from the startup hook:

1. **Log final progress:**
   ```bash
   prog log <task-id> "What you accomplished"
   ```

2. **Update task status:**
   ```bash
   prog done <task-id>           # if complete
   prog block <task-id> "reason" # if blocked
   ```

3. **Add handoff context:**
   ```bash
   prog append <task-id> "Next steps: ..."
   ```

4. **Update parent epic (if applicable):**
   ```bash
   prog append <epic-id> "Completed X, next: Y"
   ```

5. **Capture learnings:**
   If you discovered something valuable for future agents:
   ```bash
   # Check existing concepts first
   prog concepts

   # Log the learning
   prog learn "insight" -c concept --detail "explanation"
   ```

   **Good learnings are specific and actionable:**
   - ✓ "Schema migrations require built binary - go run doesn't embed assets"
   - ✓ "Use --summary to scan concepts first, full detail can overwhelm context"

   **Not learnings (use prog log instead):**
   - ✗ "Fixed the auth bug"
   - ✗ "This file handles authentication"

## Custom Commands

### /onboard

Use this to start any development session.

**Interactive mode:**
```bash
/onboard
```
- Syncs git and dependencies
- Loads project context
- Shows current work and recommendations
- You choose what to work on

**Autopilot mode:**
```bash
/onboard --auto
```
- Auto-selects top ready task
- Skips user prompts
- Good for automated workflows

### /alphie <EPIC_ID>

Use this to execute an entire epic with parallel task workers.

**Basic usage:**
```bash
/alphie ep-abc123
```

**With options:**
```bash
/alphie ep-abc123 --agents 2 --base-branch develop
```

**Dry run (see plan without executing):**
```bash
/alphie ep-abc123 --dry-run
```

**As an Alphie-spawned worker:**
- You'll receive a task ID and completion token
- Follow the worker protocol exactly
- Do NOT emit completion token until fully done
- If blocked, use `prog block` instead of emitting token

### /review

Run comprehensive code review before completing work.

**Usage:**
```bash
/review
```

**What it checks:**
- Architecture (patterns, structure, boundaries)
- Readability (clarity, maintainability, documentation)
- Security (vulnerabilities, input validation, secrets)
- Simplicity (over-engineering, unnecessary complexity)

**Act on the results:**
- **Blockers:** Must fix before merging
- **Warnings:** Should fix before merging
- **Notes:** Consider for improvements

## Code Quality Guidelines

### Simplicity First (YAGNI)

- Don't build for hypothetical futures
- Three strikes before abstracting (wait for 3 uses)
- Direct solutions over clever abstractions
- Boring technology over novel approaches

### Red Flags to Avoid

1. **Over-engineering:**
   - Premature abstraction
   - Speculative generality
   - Too many layers of indirection

2. **Scope creep:**
   - Adding features not in spec
   - "Improving" unrelated code
   - Adding comments to code you didn't change

3. **Security issues:**
   - Command injection
   - XSS, SQL injection
   - Hardcoded secrets
   - Missing input validation at boundaries

### What "Done" Means

A task is done when:
- [ ] Spec is fully satisfied (no more, no less)
- [ ] All tests pass
- [ ] Code review shows no blockers
- [ ] Changes are merged or PR is created
- [ ] prog is updated (`prog done <task-id>`)
- [ ] Learnings are captured (if any)

## Prog Best Practices

### Task Management

```bash
# Always claim before starting
prog start <task-id>

# Log progress frequently
prog log <task-id> "Clear, actionable message"

# Mark blocked if you can't proceed
prog block <task-id> "Specific reason"

# Complete only when fully done
prog done <task-id>
```

### Context Loading

```bash
# Scan concepts first if many learnings
prog context -c concept --summary

# Load specific learning by ID
prog context --id lrn-xyz

# Search by keywords
prog context -q "error handling pagination"

# Load multiple concepts
prog context -c auth -c testing
```

### Learning Capture

```bash
# List existing concepts
prog concepts

# Log a learning
prog learn "insight" -c concept --detail "explanation"

# Link to specific files
prog learn "insight" -c concept -f path/to/file.ts
```

**When to log learnings:**
- You discovered a non-obvious gotcha
- You found a technique that proved effective
- You learned something not apparent from reading code
- It would help the next agent avoid mistakes

**When NOT to log learnings:**
- Progress updates (use `prog log` instead)
- Obvious facts from the code
- Things already documented elsewhere
- Temporary workarounds

## Git Workflows

### Standard Work (single task)

Work directly on current branch:
```bash
# Make changes
git add <files>
git commit -m "message"

# Sync with main when needed
git fetch origin
git rebase origin/main
```

### Alphie Workers (parallel tasks)

Each task gets isolated worktree:
```bash
# Alphie creates worktree
git worktree add .worktrees/ts-abc123 -b alphie/ts-abc123 origin/main
cd .worktrees/ts-abc123

# Work in isolation
# Changes don't affect other workers

# Merge when complete
git rebase origin/main
# Merge via repo policy (direct or PR)
```

## Common Patterns

### Task Context Loading

```bash
# 1. Show task details
prog show <task-id>

# 2. Load suggested concepts
prog context -c concept1 -c concept2 --summary

# 3. Load specific learnings if needed
prog context --id lrn-xyz

# 4. Start work
prog start <task-id>
```

### Verification Workflow

```bash
# Run repo-standard checks
npm test           # or appropriate test command
npm run lint       # or appropriate lint command
npm run build      # or appropriate build command

# Run task-specific verification
# (check task spec for required steps)

# Review before completing
/review
```

### Completion Workflow

```bash
# Log final state
prog log <task-id> "Completed. Tests pass. PR #123 created."

# Capture learnings (if any)
prog learn "insight" -c concept

# Update parent epic (if applicable)
prog append <epic-id> "Done: ts-abc123 - implemented X"

# Mark complete
prog done <task-id>
```

## Troubleshooting

### "Can't find prog command"

Ensure prog is installed and initialized:
```bash
prog init
```

### "Task is blocked"

Check dependencies:
```bash
prog show <task-id>  # See what blocks it
prog ready           # See what's unblocked
```

### "Too much context loaded"

Use targeted loading:
```bash
# Scan summaries first
prog context -c concept --summary

# Load only what you need
prog context --id lrn-specific-one
```

### "Tests failing after merge"

Rebase on latest main:
```bash
git fetch origin
git rebase origin/main
# Fix conflicts
# Re-run tests
```

## Remember

1. **prog is source of truth** for task state
2. **Never end session without updating prog**
3. **Load context before starting, not after failing**
4. **Log learnings that help future agents**
5. **Simplicity over cleverness**
6. **Verify before completing**
7. **Ask questions if spec is unclear**

## Getting Help

- Read task spec carefully (it's the source of truth)
- Check prog learnings for similar issues
- Ask human for clarification on ambiguous requirements
- Use `/review` to catch issues before they block you

## Related Documentation

- `README.md` - Project overview and setup
- `AGENTS.md` - Project-specific agent guidelines (if present)
- `AGENTS-REFERENCE.md` - Quick reference for paths and commands (if present)
- Startup hook - prog command reference (shown on session start)
