#!/bin/bash
REPO_URL="https://github.com/Takanechis/cowork-agents.git"
LOCAL_DIR="$HOME/cowork-agents"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"

if [ -d "$LOCAL_DIR/.git" ]; then
  echo "[1/2] Pulling latest..."
  cd "$LOCAL_DIR" && git pull --quiet
else
  echo "[1/2] Cloning..."
  git clone "$REPO_URL" "$LOCAL_DIR"
fi

echo "[2/2] Creating symlinks..."
mkdir -p "$CLAUDE_AGENTS_DIR"

find "$LOCAL_DIR/agents" -name "*.md" | while read f; do
  name=$(basename "$f")
  ln -sf "$f" "$CLAUDE_AGENTS_DIR/$name"
  echo "  $name -> linked"
done

echo "Done! Agents synced to ~/.claude/agents/"
