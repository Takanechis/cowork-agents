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

## 3. エージェントの呼び出し方

パイプライン（`-pipeline`）があるエージェントは、**1回の呼び出しで生成→レビュー→修正まで自動完結**します。

---

### Planning — 企画系

#### @interview-pipeline（外部取材 一気通貫）

Webリサーチ → 企画書生成 → レビュー → Go判定まで自動で実行します。

```
@interview-pipeline 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

#### @outer-interview-planner（外部取材 個別実行）

外部企業取材向け。Webリサーチから企画書を生成します。

```
@outer-interview-planner 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希

@outer-interview-planner リサーチよろ
- 企業名: hacomono
- 企業URL: https://www.hacomono.jp/
- 取材対象者: 代表取締役 蓮田健一
```

#### @inner-interview-planner（社内インタビュー）

社内メンバー・部署向け。ヒアリングメモからオウンドメディア（note）用の企画書を生成します。

```
@inner-interview-planner 部署よろ
```

テンプレートが出力されるので、埋めて送り返してください。

#### @interview-reviewer（企画書レビュー単体）

```
@interview-reviewer レビューよろ
（outer-interview-planner または inner-interview-planner が出力した企画書を貼り付け）
```

---

### Writing — ライティング系

#### @manuscript-pipeline（原稿 一気通貫）

原稿生成 → レビュー → Go判定まで自動で実行します。完成原稿はGoogle Docsに出力されます。

```
@manuscript-pipeline インタビューよろ
（音声文字起こしテキストを貼り付け）

@manuscript-pipeline メールよろ
```

#### @manuscript-writer（原稿生成 個別実行）

```
@manuscript-writer インタビューよろ
（音声文字起こしテキストを貼り付け）

@manuscript-writer メールよろ

@manuscript-writer チャットよろ
```

#### @manuscript-reviewer（原稿レビュー単体）

```
@manuscript-reviewer レビューよろ
（manuscript-writer が出力した原稿を貼り付け）

@manuscript-reviewer 表記チェック
（原稿テキストを貼り付け）
```

#### @press-release-writer（プレスリリース生成）

```
@press-release-writer 企画よろ
```

テンプレートが出力されるので、埋めて送り返してください。

```
@press-release-writer PRよろ
【ニュース種別】新機能リリース
【発表日】2026年4月1日
【ニュースのキーポイント】
  - medicalforce に新機能〇〇を追加
  - 導入院数700院以上の知見をもとに開発
【背景・課題】〇〇の課題があった
【ターゲット読者】業界メディア / 潜在顧客
```

#### @press-release-reviewer（プレスリリースレビュー単体）

```
@press-release-reviewer レビューよろ
（press-release-writer が出力した原稿を貼り付け）

@press-release-reviewer 表記チェック
（原稿テキストを貼り付け）
```

---

### Ops — 業務オペレーション系

#### @contract-miner（契約データマイニング）

Hubbleから契約書を解析し、NotionにDB化します。

```
@contract-miner Hubbleの契約書をNotionにDB化して

@contract-miner 最新の契約書を確認してNotionに登録して
```

#### @web-builder（Webサイト構築）

corporate.v4（WordPress）の保守運用・新規ページ作成を担当します。

```
@web-builder /recruit ページにインターンセクションを追加して

@web-builder トップページのファーストビューを修正して
```

---

### Internal — 社内向け

#### @communication-branding（デザインシステム）

ブランドガイドライン・デザインシステムの作成と保守運用を担当します。

```
@communication-branding ブランドガイドラインを更新して

@communication-branding 新しいコンポーネントのデザインルールを追加して
```

#### @new-graduate（新卒・新入社員サポート）※未整備

```
@new-graduate 社内ツールの使い方を教えて


@new-graduate オンボーディングのチェックリストを出して
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
│   ├── shared/              # 全エージェント共通（表記DB・Markdownルール）
│   ├── interview/           # インタビュー企画スキル
│   ├── manuscript-writing/  # 原稿ライティングスキル
│   ├── press-release/       # プレスリリーススキル
│   └── owned-media-planning/ # オウンドメディア企画スキル
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
