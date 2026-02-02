# GSD Loop All - Design Document

**Date:** 2026-02-02
**Status:** Approved

## Overview

A skill that automatically runs the plan → execute → verify loop on ALL phases of a GSD project until completion. Designed for "sleep and wake up to done" workflows.

## Command

```
/gsd:loop-all [--auto] [--from N] [--foreground]
```

### Arguments

| Argument | Description |
|----------|-------------|
| `--auto` | Full autopilot mode. Only stops on unrecoverable errors. |
| `--from N` | Start from phase N (default: current phase from STATE.md) |
| `--foreground` | Run in current session instead of background |

## Core Loop

```
for each phase N (from start to last phase in ROADMAP.md):
    1. /gsd:plan-phase N
    2. /gsd:execute-phase N
    3. Run gsd-verifier to check must_haves
    4. If verification fails:
       - Auto-run /gsd:plan-phase N --gaps
       - Auto-run /gsd:execute-phase N --gaps-only
       - Retry up to 3 times
       - If still failing → STOP, report status
    5. Mark phase complete in ROADMAP.md
    6. Continue to phase N+1

when all phases complete:
    - Report summary
    - Offer /gsd:complete-milestone
```

## Error Handling

| Failure | Auto Mode Behavior | Retry Limit |
|---------|-------------------|-------------|
| Plan creation fails | Stop, report which phase | 0 (needs human) |
| Executor crashes | Retry same plan | 2 retries |
| Verification fails (gaps) | Auto-run `--gaps` fix loop | 3 iterations |
| Gaps still failing after 3 | Stop, report gaps | - |
| Git conflict | Stop, report conflict | 0 (needs human) |

## State Management

### STATE.md Updates

After each step:
```yaml
Loop Status: running
Current Phase: N
Current Step: planning|executing|verifying|gap-fixing
```

### Progress File

Creates `.planning/LOOP-PROGRESS.md`:

```markdown
# Loop Progress

Started: 2026-02-02 14:30
Mode: auto

## Phase 1: Setup - ✅ Complete
- Plan: 2 plans created
- Execute: completed
- Verify: passed

## Phase 2: Auth - 🔄 Executing
- Plan: 3 plans created
- Execute: in progress (wave 2/3)

## Phases Remaining: 3, 4, 5
```

## Verification Strategy

After each phase executes:

1. **Auto-verify** via `gsd-verifier` agent checking:
   - All `must_haves.truths` observable in codebase
   - All `must_haves.artifacts` (files) exist
   - All `must_haves.key_links` (integrations) work

2. **Gap-fix loop** (if gaps found):
   ```
   gap_iteration = 0
   while gaps exist AND gap_iteration < 3:
       /gsd:plan-phase N --gaps
       /gsd:execute-phase N --gaps-only
       re-run gsd-verifier
       gap_iteration++
   ```

3. **Failure handling:**
   - Write failure report to LOOP-PROGRESS.md
   - Stop loop
   - Exit with actionable message

## Background Execution

Default behavior in `--auto` mode:
1. Validate ROADMAP.md exists with phases
2. Show phase list and scope
3. Launch in background via Task tool
4. Return immediately with progress file location

User can check `.planning/LOOP-PROGRESS.md` for status.

## Skipped Steps

- **discuss-phase**: Requires interactive Q&A. Run manually before loop if needed.
- **verify-work (UAT)**: Interactive user acceptance testing. Run manually after loop if desired.

## Recovery

If loop stops (error or crash):
- STATE.md preserves position
- Run `/gsd:loop-all --auto` to resume from last incomplete phase
- Completed phases are not re-run

## File Location

```
.claude/commands/gsd-loop-all.md
```

Local skill that invokes existing GSD commands via Skill tool.
