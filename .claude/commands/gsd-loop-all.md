---
name: gsd:loop-all
description: Run plan/execute/verify loop on ALL phases until done. Use --auto for hands-off "sleep and wake up to done" mode.
arguments:
  - name: flags
    description: "--auto (autopilot), --from N (start phase), --foreground (don't background)"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
  - Task
  - Skill
  - AskUserQuestion
  - TaskCreate
  - TaskUpdate
  - TaskList
---

# GSD Loop All

Automatically run the full GSD loop (plan → execute → verify) on ALL remaining phases until the milestone is complete.

## Parse Arguments

Parse the provided arguments for:
- `--auto`: Full autopilot mode (default: false, will pause between phases)
- `--from N`: Start from phase N (default: read from STATE.md or start at phase 1)
- `--foreground`: Run in current session (default in non-auto: true, default in auto: false)

## Pre-Flight Checks

Before starting, validate:

1. **ROADMAP.md exists** at `.planning/ROADMAP.md`
   - If not: STOP with "No ROADMAP.md found. Run /gsd:new-project first."

2. **Phases are defined** in ROADMAP.md
   - Parse all `## Phase N:` entries
   - If none: STOP with "No phases found in ROADMAP.md."

3. **STATE.md exists** at `.planning/STATE.md`
   - If not: Create minimal STATE.md with `Current Phase: 1`

4. **Determine starting phase:**
   - If `--from N` provided: start at N
   - Else: read `Current Phase` from STATE.md
   - Validate phase exists in ROADMAP.md

## Initialize Progress Tracking

Create or update `.planning/LOOP-PROGRESS.md`:

```markdown
# Loop Progress

Started: [timestamp]
Mode: [auto|interactive]
Starting Phase: [N]

---

```

## Main Loop

For each phase from starting phase to final phase:

### Step 1: Update Progress

Write to LOOP-PROGRESS.md:
```markdown
## Phase [N]: [Name] - 🔄 Planning
```

Update STATE.md:
```
Loop Status: running
Current Phase: [N]
Current Step: planning
```

### Step 2: Plan Phase

Invoke: `/gsd:plan-phase [N]`

- If plan creation fails: STOP loop, report error
- On success: Update progress "Plan: [X] plans created"

### Step 3: Execute Phase

Update STATE.md: `Current Step: executing`
Update LOOP-PROGRESS.md: "🔄 Executing"

Invoke: `/gsd:execute-phase [N]`

- If executor crashes: Retry up to 2 times
- If still failing: STOP loop, report error
- On success: Update progress with execution summary

### Step 4: Verify Phase

Update STATE.md: `Current Step: verifying`
Update LOOP-PROGRESS.md: "🔄 Verifying"

Spawn `gsd-verifier` agent via Task tool to check:
- must_haves.truths are observable
- must_haves.artifacts exist
- must_haves.key_links work

Read the resulting VERIFICATION.md file.

### Step 5: Gap-Fix Loop (if needed)

If verification found gaps:

```
gap_iteration = 0
MAX_GAP_ITERATIONS = 3

while gaps_exist AND gap_iteration < MAX_GAP_ITERATIONS:
    Update progress: "🔧 Fixing gaps (attempt [gap_iteration + 1]/3)"
    Update STATE.md: Current Step: gap-fixing

    Invoke: /gsd:plan-phase [N] --gaps
    Invoke: /gsd:execute-phase [N] --gaps-only

    Re-run gsd-verifier
    Check VERIFICATION.md for remaining gaps

    gap_iteration++

if gaps still exist:
    Update progress: "❌ Failed - gaps remain after 3 attempts"
    STOP loop with message:
    "Phase [N] stuck after 3 gap-fix attempts.
     See .planning/milestones/.../[N]-VERIFICATION.md for details.
     Fix manually and run /gsd:loop-all --from [N] to resume."
```

### Step 6: Mark Phase Complete

Update ROADMAP.md: Phase N status → complete
Update LOOP-PROGRESS.md: "✅ Complete"
Update STATE.md: `Current Phase: [N+1]`

Commit planning docs:
```bash
git add .planning/
git commit -m "Phase [N] complete - [phase name]"
```

### Step 7: Continue or Pause

If `--auto` mode:
- Proceed to next phase immediately

If interactive mode:
- Ask: "Phase [N] complete. Continue to Phase [N+1]? (yes/no)"
- If no: STOP loop gracefully, report status

## Loop Completion

When all phases are complete:

1. Update LOOP-PROGRESS.md:
```markdown
---

## Summary

All phases complete!
Total phases: [N]
Started: [timestamp]
Completed: [timestamp]

Run /gsd:complete-milestone to finish the milestone.
```

2. Update STATE.md:
```
Loop Status: complete
Current Phase: done
```

3. Final message:
```
🎉 All [N] phases complete!

Check .planning/LOOP-PROGRESS.md for full history.
Run /gsd:complete-milestone to archive this milestone.
```

## Background Execution (--auto mode)

When running in auto mode without --foreground:

1. Show summary of what will run:
   - List all phases to execute
   - Estimated scope

2. Ask for confirmation: "Start loop in background?"

3. If confirmed:
   - Launch the loop via Task tool with `run_in_background: true`
   - Return immediately with:
     "Loop running in background.
      Check progress: cat .planning/LOOP-PROGRESS.md
      Output file: [task output path]"

4. The background task runs the full loop, updating LOOP-PROGRESS.md throughout

## Error Recovery

If the loop stops for any reason:

1. STATE.md preserves exact position (phase + step)
2. LOOP-PROGRESS.md shows what completed and what failed
3. User runs `/gsd:loop-all --auto` to resume
4. Loop reads STATE.md and continues from last incomplete phase
5. Completed phases are NOT re-run

## Important Notes

- **discuss-phase is skipped**: It requires interactive Q&A. Run `/gsd:discuss-phase N` manually before the loop if you want context captured for specific phases.

- **UAT is skipped**: Interactive user acceptance testing (`/gsd:verify-work`) is not run. The automated `gsd-verifier` handles machine-checkable verification. Run UAT manually after loop completion if desired.

- **Atomic commits**: Each phase completion is committed separately, enabling precise rollback if needed.

- **Fresh contexts**: Each phase runs in a fresh agent context to prevent degradation over long loops.
