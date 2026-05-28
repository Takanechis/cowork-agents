#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Takanechis/cowork-agents.git"
LOCAL_DIR="$HOME/cowork-agents"
CLAUDE_DIR="$HOME/.claude"
AGENTS_DIR="$CLAUDE_DIR/agents"

# Idempotency: if already set up for this LOCAL_DIR, just pull and exit
MARKER="$CLAUDE_DIR/.cowork_setup"
if [ -f "$MARKER" ] && [ "$(cat "$MARKER")" = "$LOCAL_DIR" ]; then
  git -C "$LOCAL_DIR" pull --quiet 2>/dev/null || true
  exit 0
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " AI編集部 セットアップ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# [1/4] Clone or pull
if [ -d "$LOCAL_DIR/.git" ]; then
  echo "[1/4] リポジトリを最新化..."
  git -C "$LOCAL_DIR" pull --quiet
else
  echo "[1/4] リポジトリをクローン..."
  git clone "$REPO_URL" "$LOCAL_DIR"
fi

# [2/4] Agent symlinks
echo "[2/4] エージェントをリンク..."
mkdir -p "$AGENTS_DIR"
count=0
while IFS= read -r -d '' f; do
  name="$(basename "$f")"
  ln -sf "$f" "$AGENTS_DIR/$name"
  count=$((count + 1))
done < <(find "$LOCAL_DIR/agents" -name "*.md" -print0)
echo "  $count 件リンク完了"

# [3/4] ~/.claude/CLAUDE.md
echo "[3/4] CLAUDE.md を設定..."
TEMPLATE="$LOCAL_DIR/templates/global-claude.md"
TARGET_MD="$CLAUDE_DIR/CLAUDE.md"
if [ ! -f "$TARGET_MD" ]; then
  sed "s|{{REPO_PATH}}|$LOCAL_DIR|g" "$TEMPLATE" > "$TARGET_MD"
  echo "  作成: $TARGET_MD"
else
  echo "  既存の CLAUDE.md はそのまま（上書きしません）"
fi

# [4/4] ~/.claude/settings.json - SessionStart で git pull
echo "[4/4] 起動フックを設定..."
SETTINGS="$CLAUDE_DIR/settings.json"
GIT_PULL_CMD="git -C '$LOCAL_DIR' pull --quiet 2>/dev/null || true"

if [ ! -f "$SETTINGS" ]; then
  cat > "$SETTINGS" << SETTINGS_EOF
{
  "hooks": {
    "SessionStart": [
      {"type": "command", "command": "$GIT_PULL_CMD"}
    ]
  }
}
SETTINGS_EOF
  echo "  settings.json を作成しました"
elif ! grep -q "cowork-agents.*git pull\|git pull.*cowork-agents" "$SETTINGS" 2>/dev/null; then
  python3 - "$SETTINGS" "$GIT_PULL_CMD" << 'PY'
import json, sys
path, cmd = sys.argv[1], sys.argv[2]
with open(path) as f:
    s = json.load(f)
s.setdefault("hooks", {}).setdefault("SessionStart", []).append(
    {"type": "command", "command": cmd}
)
with open(path, "w") as f:
    json.dump(s, f, indent=2, ensure_ascii=False)
PY
  echo "  git pull フックを追加しました"
else
  echo "  フックは既に設定済みです"
fi

# Mark as done
echo "$LOCAL_DIR" > "$MARKER"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " ✅ セットアップ完了"
echo "    Claude Code を再起動してください"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
