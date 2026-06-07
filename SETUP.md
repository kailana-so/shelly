# Setup on a new machine

## 1. Clone & install

```sh
git clone <this repo url> ~/Documents/shells
~/Documents/shells/install.sh
```

`install.sh` symlinks each `bin/*` into `~/.local/bin/`. Make sure that dir is on `PATH` (one line in `.zshrc`):

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## 2. Dependencies

Install whichever you don't already have:

```sh
brew install tmux fzf gum
```

Optional / context-dependent:
- **Ghostty** — `viewtrees` uses AppleScript to split Ghostty terminals; `claude-notify` activates it. If you use a different terminal, those actions are degraded but the rest still works.
- **Cursor** — only needed for `viewtrees`'s `open in cursor` action.
- **nyx** — only needed for `viewtrees`'s `open with nyx` action (`nyx chat`).

## 3. Claude Code hooks

`~/.claude/settings.json` needs to point at the hook scripts:

```json
{
  "hooks": {
    "Notification": [
      { "hooks": [{ "type": "command", "command": "$HOME/.local/bin/claude-notify" }] }
    ],
    "Stop": [
      { "hooks": [{ "type": "command", "command": "$HOME/.local/bin/claude-stop-hook" }] }
    ]
  }
}
```

Without these, `viewtrees` can't tell `⚡ busy` from `✓ waiting` — sessions just show `●`.

## 4. Optional: pin a default "main repo" for `worktree`

If you mostly work inside one primary repo on this machine, you can stop typing the path every time. `worktree` accepts the source repo as its second arg, defaulting to cwd's git root. Wrap it in a shell function so a no-arg invocation Just Works:

```sh
# ~/.zshrc
WORK_REPO="$HOME/Projects/<your-main-repo>"
work() { worktree "$@" "$WORK_REPO"; }
prune-main() { prunetrees "$WORK_REPO"; }
```

Now `work feature-x` makes a worktree of the pinned repo regardless of cwd, while plain `worktree feature-x` still uses cwd.

## 5. Optional: point `viewtrees` at a non-default repo dir

`viewtrees` defaults to scanning `~/Documents/` for git repos. If your repos live elsewhere on this machine (e.g. `~/code/`, `~/Projects/`), set `VIEWTREES_DIR`:

```sh
# ~/.zshrc
export VIEWTREES_DIR="$HOME/code"
```

### Worked example — home machine, pre-extraction

Before this repo existed, the home machine had `worktree` hardcoded to a single project:

```bash
# ~/.local/bin/worktree (the old, pre-portable version)
MAIN_REPO="$HOME/Projects/your-main-repo"
BUILDS_DIR="$HOME/Documents/your-main-repo-builds"
# ...
cp "$MAIN_REPO/webclient/.env" "$WORKTREE_PATH/webclient/.env" 2>/dev/null || true
cp "$MAIN_REPO/server/.env"    "$WORKTREE_PATH/server/.env"    2>/dev/null || true
```

The portable equivalent is a one-liner in `.zshrc`:

```sh
MY_REPO="$HOME/Projects/your-main-repo"
work() { worktree "$@" "$MY_REPO"; }
```

The portable `worktree` already auto-globs `*/.env` files (depth 1), which catches `webclient/.env` and `server/.env` without needing project-specific copy logic.

## 6. Verify

```sh
tools           # prints the tool list
viewtrees         # opens the fzf picker
worktree        # bare invocation prints usage
```

If something doesn't work, re-run `install.sh` (idempotent) or check `~/.local/bin/<name>` is a symlink into `~/Documents/shells/bin/`.
