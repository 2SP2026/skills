---
name: 2sp-git-check
description: Automates the checking and synchronization of all git repositories in the Antigravity workspace against their GitHub remotes.
---

# 2sp-git-check: Workspace Git Synchronization

This skill provides a standardized protocol for identifying, checking, and syncing all git-enabled projects within the `/Users/leol/Desktop/Antigravity` workspace.

## Core Objective

Ensure all local project forks are synchronized with their respective GitHub repositories and provide a clear, categorized status report.

## Execution Protocol

### Phase 1: Discovery

Scan the `/Users/leol/Desktop/Antigravity` directory for all immediate subdirectories containing a `.git/` folder. Skip hidden directories (those starting with `.`).

### Phase 2: Analysis & Sync

For each discovered repository, execute the following logic **in a subshell** to ensure directory isolation:

1. **Check Working Tree**: If the working directory is dirty (uncommitted changes), flag as "DIRTY" and skip sync operations.
2. **Check Upstream**: Verify that an upstream tracking branch exists. If not, flag as "NO UPSTREAM" and skip.
3. **Fetch Updates**: Run `git fetch --quiet` to synchronize remote tracking refs.
4. **Compare State**: Determine the relationship between local `HEAD` and upstream:
   - **UP TO DATE**: Local and remote are identical.
   - **BEHIND**: Local is behind remote → Execute `git pull --quiet`.
   - **AHEAD**: Local has unpushed commits → Report only (no auto-push).
   - **DIVERGED**: Local and remote have diverged → Flag for manual intervention.
5. **Capture Result**: Record the status and any actions taken.

### Phase 3: Reporting

Generate a categorized summary with counts:

- ✅ **Up to Date**: Repos already synchronized.
- ⬇️ **Pulled**: Repos where updates were successfully pulled.
- ⬆️ **Ahead**: Repos with local commits not yet pushed.
- ⚠️ **Dirty**: Repos with uncommitted local changes (skipped).
- ❌ **Diverged**: Repos requiring manual merge resolution.
- 🚫 **No Upstream**: Repos without a configured tracking branch.
- 💥 **Errors**: Repos where fetch/pull failed unexpectedly.

---

## Reference Implementation (zsh/bash)

This script is the canonical implementation. Execute it directly or use it as a reference for agentic tool calls.

```bash
#!/bin/bash
set -euo pipefail

WORKSPACE="/Users/leol/Desktop/Antigravity"

# Result accumulators
declare -a UP_TO_DATE=()
declare -a PULLED=()
declare -a AHEAD=()
declare -a DIRTY=()
declare -a DIVERGED=()
declare -a NO_UPSTREAM=()
declare -a ERRORS=()

echo "═══════════════════════════════════════════════════════════"
echo "  2SP Git Check — Workspace Synchronization"
echo "  Workspace: $WORKSPACE"
echo "  Started: $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════════════════════"
echo ""

cd "$WORKSPACE"

for dir in */; do
    # Skip if not a git repository
    [[ ! -d "${dir}.git" ]] && continue
    
    repo_name="${dir%/}"
    
    # Run in subshell to isolate directory changes and errors
    result=$(
        cd "$dir" 2>/dev/null || { echo "ERROR:Cannot access directory"; exit 1; }
        
        # Check for dirty working tree
        if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
            echo "DIRTY"
            exit 0
        fi
        
        # Check for upstream tracking branch
        upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null) || {
            echo "NO_UPSTREAM"
            exit 0
        }
        
        # Fetch latest from remote
        git fetch --quiet 2>/dev/null || {
            echo "ERROR:Fetch failed"
            exit 0
        }
        
        # Compare local vs remote
        local_sha=$(git rev-parse @ 2>/dev/null)
        remote_sha=$(git rev-parse '@{u}' 2>/dev/null)
        base_sha=$(git merge-base @ '@{u}' 2>/dev/null)
        
        if [[ "$local_sha" == "$remote_sha" ]]; then
            echo "UP_TO_DATE"
        elif [[ "$local_sha" == "$base_sha" ]]; then
            # Local is behind, pull updates
            if git pull --quiet 2>/dev/null; then
                echo "PULLED"
            else
                echo "ERROR:Pull failed"
            fi
        elif [[ "$remote_sha" == "$base_sha" ]]; then
            # Local is ahead
            echo "AHEAD"
        else
            # Diverged
            echo "DIVERGED"
        fi
    )
    
    # Categorize result
    case "$result" in
        UP_TO_DATE)
            UP_TO_DATE+=("$repo_name")
            echo "  ✅  $repo_name — Up to date"
            ;;
        PULLED)
            PULLED+=("$repo_name")
            echo "  ⬇️   $repo_name — Pulled updates"
            ;;
        AHEAD)
            AHEAD+=("$repo_name")
            echo "  ⬆️   $repo_name — Ahead (unpushed commits)"
            ;;
        DIRTY)
            DIRTY+=("$repo_name")
            echo "  ⚠️   $repo_name — Dirty working tree (skipped)"
            ;;
        DIVERGED)
            DIVERGED+=("$repo_name")
            echo "  ❌  $repo_name — DIVERGED (manual merge needed)"
            ;;
        NO_UPSTREAM)
            NO_UPSTREAM+=("$repo_name")
            echo "  🚫  $repo_name — No upstream configured"
            ;;
        ERROR:*)
            error_msg="${result#ERROR:}"
            ERRORS+=("$repo_name: $error_msg")
            echo "  💥  $repo_name — Error: $error_msg"
            ;;
        *)
            ERRORS+=("$repo_name: Unknown state")
            echo "  ❓  $repo_name — Unknown state: $result"
            ;;
    esac
done

# Summary Report
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  SUMMARY"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "  ✅ Up to Date:   ${#UP_TO_DATE[@]}"
echo "  ⬇️  Pulled:       ${#PULLED[@]}"
echo "  ⬆️  Ahead:        ${#AHEAD[@]}"
echo "  ⚠️  Dirty:        ${#DIRTY[@]}"
echo "  ❌ Diverged:     ${#DIVERGED[@]}"
echo "  🚫 No Upstream:  ${#NO_UPSTREAM[@]}"
echo "  💥 Errors:       ${#ERRORS[@]}"
echo ""

# Detail sections for action items
if [[ ${#PULLED[@]} -gt 0 ]]; then
    echo "  ── Pulled Updates ──"
    for repo in "${PULLED[@]}"; do echo "     • $repo"; done
    echo ""
fi

if [[ ${#AHEAD[@]} -gt 0 ]]; then
    echo "  ── Ahead (Consider Pushing) ──"
    for repo in "${AHEAD[@]}"; do echo "     • $repo"; done
    echo ""
fi

if [[ ${#DIRTY[@]} -gt 0 ]]; then
    echo "  ── Dirty (Commit or Stash First) ──"
    for repo in "${DIRTY[@]}"; do echo "     • $repo"; done
    echo ""
fi

if [[ ${#DIVERGED[@]} -gt 0 ]]; then
    echo "  ── DIVERGED (Manual Merge Required) ──"
    for repo in "${DIVERGED[@]}"; do echo "     • $repo"; done
    echo ""
fi

if [[ ${#NO_UPSTREAM[@]} -gt 0 ]]; then
    echo "  ── No Upstream Configured ──"
    for repo in "${NO_UPSTREAM[@]}"; do echo "     • $repo"; done
    echo ""
fi

if [[ ${#ERRORS[@]} -gt 0 ]]; then
    echo "  ── Errors ──"
    for entry in "${ERRORS[@]}"; do echo "     • $entry"; done
    echo ""
fi

echo "═══════════════════════════════════════════════════════════"
echo "  Completed: $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════════════════════"
```

---

## Agentic Execution Guide

When executing this skill as an agent (without running the full bash script), follow this per-repository logic:

### For Each Repository

```bash
# 1. Navigate and check dirty state
cd /Users/leol/Desktop/Antigravity/<repo_name>
git status --porcelain
# If output is non-empty → DIRTY, skip to next repo

# 2. Check upstream exists
git rev-parse --abbrev-ref --symbolic-full-name @{u}
# If error → NO_UPSTREAM, skip to next repo

# 3. Fetch and compare
git fetch --quiet
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

# 4. Determine state and act
# If LOCAL == REMOTE → UP_TO_DATE
# If LOCAL == BASE   → BEHIND, run: git pull --quiet
# If REMOTE == BASE  → AHEAD
# Else               → DIVERGED
```

### Reporting Format

Present results in a markdown table:

| Status | Repository | Action Taken |
|--------|------------|--------------|
| ✅ | repo_name | Up to date |
| ⬇️ | repo_name | Pulled X commits |
| ⬆️ | repo_name | Ahead by X commits |
| ⚠️ | repo_name | Skipped (dirty) |
| ❌ | repo_name | Manual merge needed |

---

## Safety Guidelines

1. **Never auto-push**: Only `git pull` is automated. Pushing requires explicit user confirmation.
2. **Skip dirty repos**: Never pull into a dirty working tree.
3. **Subshell isolation**: Always run repo operations in a subshell to prevent directory contamination.
4. **Quiet but logged**: Use `--quiet` flags but capture and report all outcomes.
5. **Fail gracefully**: One repo's failure must not abort the entire scan.

---

## Verification Checklist

After execution, verify:

- [ ] All repos were scanned (count matches expected)
- [ ] No repos in "Error" state (unless network issues)
- [ ] "Pulled" repos now show as "Up to date" on re-run
- [ ] "Dirty" repos are addressed before next sync
