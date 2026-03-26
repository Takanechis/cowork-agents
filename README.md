# cowork-agents マニュアル

アトミックソフトウェア CoWork 用オリジナルエージェント

---

## 1. 初回セットアップ

ターミナルで以下の3行を実行してください。

```bash
git clone https://github.com/Takanechis/cowork-agents.git ~/cowork-agents
chmod +x ~/cowork-agents/setup.sh
~/cowork-agents/setup.sh
```

これで ~/.claude/agents/ にシンボリックリンクが作成され、Claude Code からエージェントを呼び出せるようになります。

---

## 2. 自動同期の設定（推奨）

~/.claude/settings.json に以下を追加すると、Claude Code 起動時に自動で最新版に同期されます。

```json
{
  "hooks": {
    "SessionStart": [{
      "type": "command",
      "command": "cd ~/cowork-agents && git pull --quiet 2>/dev/null || true"
    }]
  }
}
```

これにより、GitHub上でエージェントを編集した後、次にClaude Codeを起動した瞬間に自動反映されます。

---

## 3. エージェントの呼び出し方

Claude Code のチャットで以下のように呼び出します。

### 原稿ライティング

```
@manuscript-writer 以下の音声文字起こしからブログ記事を作成して
（ここに文字起こしテキストを貼り付け）
```

```
@manuscript-writer プレスリリースを作成して。テーマ: 新機能リリース
```

```
@manuscript-writer 以下のメモからメルマガを作成して
```

### 契約データマイニング

```
@contract-miner Hubbleの契約書をNotionにDB化して
```

```
@contract-miner 最新の契約書を確認してNotionに登録して
```

### Webサイト構築

```
@web-builder /recruit ページにインターンセクションを追加して
```

```
@web-builder トップページのアニメーションを修正して
```

```
@web-builder 新しいページ /service を作成して
```

### インタビュー企画書

```
@interview-planner 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

```
@interview-planner リサーチよろ
- 企業名: hacomono
- 企業URL: https://www.hacomono.jp/
- 取材対象者: 代表取締役 蓮田健一
```

---

## 4. エージェント一覧

| エージェント | ファイル | 用途 |
|---|---|---|
| @manuscript-writer | agents/manuscript-writer.md | 音声データから原稿を自動生成 |
| @contract-miner | agents/contract-miner.md | Hubbleから契約書を解析しNotionにDB化 |
| @web-builder | agents/web-builder.md | corporate.v4の保守運用・新規ページ作成 |
| @interview-planner | agents/interview-planner.md | 企業リサーチから取材企画書を自動生成 |

---

## 5. エージェントを編集したとき

GitHub 上で agents/*.md を編集した後:

- **自動同期設定済みの場合** → Claude Code を再起動するだけ
- **手動の場合** → ~/cowork-agents/setup.sh を再実行

---

## 6. ベースシステム

[everything-claude-code](https://github.com/nichochar/everything-claude-code) をベースに構築
