# cowork-agents マニュアル

アトミックソフトウェア CoWork 用オリジナルエージェント

---

## 1. 初回セットアップ

```bash
git clone https://github.com/Takanechis/cowork-agents.git ~/cowork-agents
chmod +x ~/cowork-agents/setup.sh
~/cowork-agents/setup.sh
```

これで `~/.claude/agents/` にシンボリックリンクが作成され、Claude Code からエージェントを呼び出せるようになります。

---

## 2. 自動同期の設定（推奨）

`~/.claude/settings.json` に以下を追加すると、Claude Code 起動時に自動で最新版に同期されます。

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

---

## 3. 呼び出し方

パイプラインがあるエージェントは、**1回の呼び出しで生成→レビュー→修正まで自動完結**します。

### インタビュー企画書（外部取材）

```
@interview-pipeline 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

リサーチだけしたい場合:

```
@outer-interview-planner リサーチよろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

### インタビュー企画書（社内インタビュー）

```
@inner-interview-planner 部署よろ
```

テンプレートが出力されるので、埋めて送り返す。

### 原稿ライティング

```
@manuscript-pipeline インタビューよろ
（音声文字起こしテキストを貼り付け）
```

個別に呼び出す場合:

```
@manuscript-writer インタビューよろ
（音声文字起こしテキストを貼り付け）

@manuscript-reviewer レビューよろ
（原稿テキストを貼り付け）
```

### プレスリリース

```
@press-release-writer 企画よろ
```

テンプレートが出力されるので、埋めて送り返す。

レビューのみしたい場合:

```
@press-release-reviewer レビューよろ
（原稿テキストを貼り付け）
```

### 契約データマイニング

```
@contract-miner Hubbleの契約書をNotionにDB化して
```

### Webサイト構築

```
@web-builder /recruit ページにインターンセクションを追加して
```

---

## 4. エージェント一覧

### Planning（企画系）

| エージェント | 用途 |
|---|---|
| @interview-pipeline | 外部取材企画書を1コマンドで生成〜Go判定まで自動完結 |
| @outer-interview-planner | 外部企業取材の企画書を生成（VerticalSaaS Mag.向け、Webリサーチあり） |
| @inner-interview-planner | 社内インタビューの企画書を生成（オウンドメディアnote向け、ヒアリングメモから） |
| @interview-reviewer | インタビュー企画書のレビュー・Go判定 |

### Writing（ライティング系）

| エージェント | 用途 |
|---|---|
| @manuscript-pipeline | 原稿を1コマンドで生成〜Go判定まで自動完結 |
| @manuscript-writer | 音声データから原稿を生成（インタビュー / メール / チャット） |
| @manuscript-reviewer | 原稿の表記・トンマナ・構成をレビュー |
| @press-release-writer | プレスリリースの企画→完成原稿を生成 |
| @press-release-reviewer | プレスリリース原稿のレビュー・Go判定 |

### Ops（業務オペレーション系）

| エージェント | 用途 |
|---|---|
| @contract-miner | Hubbleから契約書を解析しNotionにDB化 |
| @web-builder | corporate.v4の保守運用・新規ページ作成 |

### Internal（社内向け）

| エージェント | 用途 |
|---|---|
| @communication-branding | デザインシステムの作成・保守運用 |
| @new-graduate | 新卒・新入社員向けサポート |

---

## 5. リポジトリ構造

```
cowork-agents/
├── agents/
│   ├── planning/     # 企画系（interview系）
│   ├── writing/      # ライティング系（manuscript・press-release系）
│   ├── ops/          # 業務オペレーション系
│   └── internal/     # 社内向け
├── skills/
│   ├── shared/           # 全エージェント共通（表記DB・Markdownルール）
│   ├── interview/        # インタビュー企画スキル
│   ├── manuscript-writing/  # 原稿ライティングスキル
│   ├── press-release/    # プレスリリーススキル
│   └── owned-media-planning/  # オウンドメディア企画スキル
├── AGENTS.md
├── CLAUDE.md
├── README.md
└── setup.sh
```

設計方針:
- agents/ = 「誰が・何をするか」（Role・Workflow）
- skills/ = 「何を基準に動くか」（品質基準・表記DB・テンプレート）

---

## 6. エージェントを編集したとき

GitHub 上で `agents/**/*.md` を編集した後:

- 自動同期設定済みの場合 → Claude Code を再起動するだけ
- 手動の場合 → `~/cowork-agents/setup.sh` を再実行

---

## 7. ベースシステム

[everything-claude-code](https://github.com/disler/everything-claude-code) をベースに構築
