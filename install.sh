#!/usr/bin/env bash
# Symlink everything in bin/ into ~/.local/bin/. Idempotent.
# On a fresh machine: clone this repo, run ./install.sh, ensure ~/.local/bin is on PATH.
#
# Existing files in ~/.local/bin/ that aren't symlinks (e.g. older copies of these
# scripts) are backed up to <name>.bak.<timestamp> rather than overwritten.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR"

# ── Brew deps ────────────────────────────────────────────────────────────────
# Required by the scripts in bin/. Auto-install on macOS via Homebrew.

NEEDED=()
command -v tmux >/dev/null 2>&1 || NEEDED+=(tmux)
command -v fzf  >/dev/null 2>&1 || NEEDED+=(fzf)
command -v gum  >/dev/null 2>&1 || NEEDED+=(gum)

if (( ${#NEEDED[@]} > 0 )); then
  if command -v brew >/dev/null 2>&1; then
    echo "→ installing missing deps: ${NEEDED[*]}"
    brew install "${NEEDED[@]}"
    echo
  else
    echo "✗ missing: ${NEEDED[*]}" >&2
    echo "  install Homebrew (https://brew.sh) and re-run, or install these manually." >&2
    exit 1
  fi
fi

# ── Symlink scripts ──────────────────────────────────────────────────────────

for script in "$REPO_DIR/bin"/*; do
  [[ -f "$script" ]] || continue
  name=$(basename "$script")
  link="$TARGET_DIR/$name"

  if [[ -L "$link" ]]; then
    ln -sf "$script" "$link"
    echo "↻ $name"
  elif [[ -e "$link" ]]; then
    backup="$link.bak.$(date +%s)"
    mv "$link" "$backup"
    ln -s "$script" "$link"
    echo "↺ $name  (existing file backed up to $(basename "$backup"))"
  else
    ln -s "$script" "$link"
    echo "+ $name"
  fi
done

cat <<EOF

Done. ~/.local/bin/ entries now point into $REPO_DIR/bin/

Make sure ~/.local/bin is on PATH (already in your .zshrc on this machine).

Claude hooks: ~/.claude/settings.json should reference
  \$HOME/.local/bin/claude-notify
  \$HOME/.local/bin/claude-stop-hook
On a new machine, copy the Notification + Stop hook stanzas from another machine's
settings.json (this repo doesn't manage that file).
EOF
