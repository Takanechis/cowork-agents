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

---

## 3. エージェントの呼び出し方

### 原稿ライティング

```
@manuscript-writer 以下の音声文字起こしからインタビュー記事を作成して
（ここに文字起こしテキストを貼り付け）

@manuscript-writer メールよろ
```

### 原稿レビュー

```
@manuscript-reviewer レビューよろ
（manuscript-writer が出力した原稿をここに貼り付け）

@manuscript-reviewer 表記チェック
（原稿テキスト）
```

### インタビュー企画書

```
@interview-writer 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希

@interview-writer リサーチよろ
- 企業名: hacomono
- 企業URL: https://www.hacomono.jp/
- 取材対象者: 代表取締役 蓮田健一
```

### インタビュー企画書レビュー

```
@interview-reviewer レビューよろ
（interview-writer が出力した企画書をここに貼り付け）
```

### プレスリリース 企画→ライティング

```
@press-release-writer 企画よろ

@press-release-writer PRよろ
【ニュース種別】新機能リリース
【発表日】2026年4月1日
【ニュースのキーポイント】
  - medicalforce に新機能〇〇を追加
  - 導入院数700院以上の知見をもとに開発
  - 提供開始: 2026年4月1日（既存ユーザは無償提供）
【背景・課題】〇〇の課題があった
【ターゲット読者】業界メディア / 潜在顧客
```

### プレスリリース 原稿レビュー

```
@press-release-reviewer レビューよろ
（press-release-writer が出力した原稿をここに貼り付け）
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

### Writing（ライティング系）

| エージェント | ファイル | 用途 |
|---|---|---|
| @manuscript-writer | agents/writing/manuscript-writer.md | 音声データから原稿を自動生成 |
| @manuscript-reviewer | agents/writing/manuscript-reviewer.md | 原稿の表記・トンマナ・構成をレビュー |
| @interview-writer | agents/writing/interview-writer.md | 企業リサーチから取材企画書を自動生成 |
| @interview-reviewer | agents/writing/interview-reviewer.md | インタビュー企画書のレビュー・Go判定 |
| @press-release-writer | agents/writing/press-release-writer.md | プレスリリースの企画→完成原稿を一気通貫で生成 |
| @press-release-reviewer | agents/writing/press-release-reviewer.md | プレスリリース原稿のレビュー・Go判定 |

### Planning（企画・メディア系）

| エージェント | ファイル | 用途 |
|---|---|---|
| @owned-media-planner | agents/planning/owned-media-planner.md | オウンドメディア向けインタビュー企画書を生成 |

### Ops（業務オペレーション系）

| エージェント | ファイル | 用途 |
|---|---|---|
| @contract-miner | agents/ops/contract-miner.md | Hubbleから契約書を解析しNotionにDB化 |
| @web-builder | agents/ops/web-builder.md | corporate.v4の保守運用・新規ページ作成 |

### Internal（社内向け）

| エージェント | ファイル | 用途 |
|---|---|---|
| @communication-branding | agents/internal/communication-branding.md | デザインシステムの作成・保守運用 |
| @new-graduate | agents/internal/new-graduate.md | 新卒・新入社員向けサポート |

---

## 5. リポジトリ構造

```
cowork-agents/
├── agents/
│   ├── writing/          # ライティング系エージェント
│   ├── planning/         # 企画・メディア系エージェント
│   ├── ops/              # 業務オペレーション系エージェント
│   └── internal/         # 社内向けエージェント
├── skills/
│   ├── shared/           # 全エージェント共通スキル（表記DB・Markdownルール）
│   ├── interview/        # インタビュー企画・原稿スキル
│   ├── manuscript-writing/  # 原稿ライティングスキル
│   ├── press-release/    # プレスリリーススキル
│   └── owned-media-planning/  # オウンドメディア企画スキル
├── AGENTS.md
├── CLAUDE.md
├── README.md
└── setup.sh
```

設計方針:
- agents/ = 「誰が・何をするか」（Role・Workflow・Input/Output Rules）
- skills/ = 「何を基準に・何を参照して動くか」（品質基準・表記DB・テンプレート）

---

## 6. エージェントを編集したとき

GitHub 上で `agents/**/*.md` を編集した後:

- 自動同期設定済みの場合 → Claude Code を再起動するだけ
- 手動の場合 → `~/cowork-agents/setup.sh` を再実行

---

## 7. ベースシステム

[everything-claude-code](https://github.com/disler/everything-claude-code) をベースに構築
