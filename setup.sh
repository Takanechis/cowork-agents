#!/bin/bash
set -e

REPO_URL="https://github.com/Takanechis/cowork-agents.git"
LOCAL_DIR="$HOME/cowork-agents"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"

echo "=== cowork-agents setup ==="

# Clone or Pull
if [ -d "$LOCAL_DIR/.git" ]; then
  echo "[1/2] Pulling latest..."
    cd "$LOCAL_DIR" && git pull --quiet
    else
      echo "[1/2] Cloning..."
        git clone "$REPO_URL" "$LOCAL_DIR"
        fi

        # Symlink agents
        echo "[2/2] Creating symlinks..."
        mkdir -p "$CLAUDE_AGENTS_DIR"

        for f in "$LOCAL_DIR"/agents/*.md; do
          name=$(basename "$f")
            ln -sf "$f" "$CLAUDE_AGENTS_DIR/$name"
              echo "  $name -> linked"
              done

              echo "Done! Agents synced to ~/.claude/agents/"
