# shells

Personal shell tools — git worktree navigation, Claude Code workflow helpers, tmux session orchestration.

## Tools

| Command | What it does |
|---|---|
| `worktree <name> [<repo>]` | Create/attach a git worktree under `<repo-parent>/<repo>-builds/` and a tmux session running `claude` |
| `prunetree <name> [<repo>]` | Remove one git worktree by name (basename of dir or branch name) |
| `prunetrees [<repo>]` | Interactive multi-select prune of stale worktrees (gum picker) |
| `viewtrees` | fzf picker — navigate repos and tmux sessions under `~/Documents/`, with `open with nyx` / `open with claude` / `open in cursor` actions |
| `growtree` | Spawn `claude` in a tmux session named after the current git branch (grows a session on the current tree, contrasted with `worktree` which forks a new one) |
| `claude-notify` | Claude Code Notification hook — `⚡ <branch>` tmux window + macOS notification |
| `claude-stop-hook` | Claude Code Stop hook — `✓ <branch>` tmux window |
| `tools` | Print the list above |

`worktree`, `prunetree`, and `prunetrees` default to the current git repo (cwd's git root) and accept an explicit repo path as the last arg.

## Install

```sh
git clone <this repo> ~/Documents/shells
~/Documents/shells/install.sh
```

`install.sh` symlinks each `bin/*` into `~/.local/bin/`. Re-run after pulling changes — symlinks just need to exist; they always reflect the current repo state.

Existing files in `~/.local/bin/` that aren't symlinks (e.g. older standalone copies of these scripts) get backed up to `<name>.bak.<timestamp>` rather than overwritten.

## Claude Code hooks

`claude-notify` and `claude-stop-hook` are referenced from `~/.claude/settings.json` per machine. On a new machine, add (or copy from another machine):

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

These hooks fire only for Claude Code (`claude`) sessions, not for `nyx chat`. That's intentional — claude owns the worktree/status infrastructure; nyx is the LLM toolkit.

## Dependencies

| Tool | Required by |
|---|---|
| `tmux` | `worktree`, `viewtrees`, `growtree`, `claude-notify`, `claude-stop-hook` |
| `fzf` | `viewtrees` |
| `gum` | `prunetree`, `prunetrees` |
| `Ghostty` | `viewtrees` (AppleScript splits), `claude-notify` (activation) |
| `Cursor` | `viewtrees`'s `open in cursor` action (optional) |
| `nyx` | `viewtrees`'s `open with nyx` action (optional — points at `nyx chat`) |
