# cowork-agents マニュアル

アトミックソフトウェア CoWork 用オリジナルエージェント

---

## 1. 初回セットアップ

ターミナルで1行実行するだけです。

```bash
curl -sSf https://raw.githubusercontent.com/Takanechis/cowork-agents/main/setup.sh | bash
```

自動でやること:

- リポジトリを `~/cowork-agents` にクローン
- `~/.claude/agents/` にエージェントのシンボリックリンクを作成
- `~/.claude/CLAUDE.md` に編集部グローバル設定を配置
- Claude Code 起動時に自動 pull するフックを `~/.claude/settings.json` に追加

完了後、Claude Code を再起動してください。

**このリポジトリを Claude Code で開くと、次回以降は自動でセットアップが走ります。**

---

## 2. 自動同期について

セットアップ完了後は、Claude Code を起動するたびに `git pull` が走り、常に最新のエージェントが使えます。手動での再実行は不要です。

---

## 3. エージェントの呼び出し方

パイプライン（`-pipeline`）があるエージェントは、1回の呼び出しで生成→レビュー→修正まで自動完結します。

---

### 🚀 PRよろ — ワンコマンド PR エントリーポイント

PR 業務（企画・ライティング・レビュー）を何でも `@pr-director` に投げると、内容を判断して適切なエージェントに委任します。

```
@pr-director PRよろ
（やりたいことを自然文で書く）
```

**ルーティング例:**

| 入力例 | ルーティング先 |
|---|---|
| `PRよろ 〇〇社の取材企画書を作りたい` | 外部取材 → `@outer-interview-planner` |
| `PRよろ 社内インタビューの企画書を作りたい` | 社内 → `@inner-interview-planner` |
| `PRよろ プレスリリースを書きたい` | `@press-release-writer` |
| `PRよろ 原稿のレビューを頼みたい` | `@manuscript-reviewer` |
| `PRよろ プレスリリースのレビューをしてほしい` | `@press-release-reviewer` |

---

### Planning — 企画系

**@interview-pipeline（外部取材 一気通貫）**

Webリサーチ → 企画書生成 → レビュー → Go判定まで自動で実行します。

```
@interview-pipeline 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

**@outer-interview-planner（外部取材 個別実行）**

外部企業取材向け。Webリサーチから企画書を生成します。

```
@outer-interview-planner 企画書よろ
- 企業名: アイザック株式会社
- 企業URL: https://aisaac.jp/
- 取材対象者: 代表取締役CEO 田中和希
```

**@inner-interview-planner（社内インタビュー）**

社内メンバー・部署向け。ヒアリングメモからオウンドメディア（note）用の企画書を生成します。

```
@inner-interview-planner 部署よろ
テンプレートが出力されるので、埋めて送り返してください。
```

**@interview-reviewer（企画書レビュー単体）**

```
@interview-reviewer レビューよろ
（outer-interview-planner または inner-interview-planner が出力した企画書を貼り付け）
```

---

### Writing — ライティング系

**@manuscript-pipeline（原稿 一気通貫）**

原稿生成 → レビュー → Go判定まで自動で実行します。完成原稿はGoogle Docsに出力されます。

```
@manuscript-pipeline インタビューよろ
（音声文字起こしテキストを貼り付け）
```

**@manuscript-writer（原稿生成 個別実行）**

```
@manuscript-writer インタビューよろ
（音声文字起こしテキストを貼り付け）
```

**@manuscript-reviewer（原稿レビュー単体）**

```
@manuscript-reviewer レビューよろ
（manuscript-writer が出力した原稿を貼り付け）
```

**@press-release-writer（プレスリリース生成）**

```
@press-release-writer 企画よろ
テンプレートが出力されるので、埋めて送り返してください。
```

**@press-release-reviewer（プレスリリースレビュー単体）**

```
@press-release-reviewer レビューよろ
（press-release-writer が出力した原稿を貼り付け）
```

---

### Review — 導入事例記事系

導入事例記事（Q&Aインタビュー形式）のレビュー・編集を担当するエージェント群です。  
パイプライン（`@case-study-pipeline`）で一気通貫実行できます。

**@case-study-pipeline（導入事例 一気通貫）**

レビュー → 論理矛盾の指摘 → 文脈補足編集まで自動で実行します。

```
@case-study-pipeline パイプライン実行
（導入事例原稿テキストを貼り付け）
```

**@case-study-reviewer（導入事例レビュー単体）**

```
@case-study-reviewer レビューよろ
（導入事例原稿テキストを貼り付け）
```

**@case-study-editor（文脈補足編集 単体）**

```
@case-study-editor 編集よろ
（導入事例原稿テキストを貼り付け）
```

---

### Ops — 業務オペレーション系

**@contract-miner（契約データマイニング）**

Hubbleから契約書を解析し、NotionにDB化します。

```
@contract-miner Hubbleの契約書をNotionにDB化して
```

**@web-builder（Webサイト構築）**

corporate.v4（WordPress）の保守運用・新規ページ作成を担当します。

```
@web-builder /recruit ページにインターンセクションを追加して
```

---

### Internal — 社内向け

**@communication-branding（デザインシステム）**

```
@communication-branding ブランドガイドラインを更新して
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
| @pr-director | 「PRよろ」エントリーポイント — 内容を判断して適切なエージェントに委任 |
| @manuscript-pipeline | 原稿を1コマンドで生成〜Go判定まで自動完結 |
| @manuscript-writer | 音声データから原稿を生成（インタビュー / メール / チャット） |
| @manuscript-reviewer | 原稿の表記・トンマナ・構成をレビュー |
| @press-release-writer | プレスリリースの企画→完成原稿を生成 |
| @press-release-reviewer | プレスリリース原稿のレビュー・Go判定 |

### Review（導入事例記事系）

| エージェント | 用途 |
|---|---|
| @case-study-pipeline | 導入事例記事をレビュー〜文脈補足編集まで一気通貫で実行 |
| @case-study-reviewer | 導入事例記事の表記・構成・論理矛盾をレビュー |
| @case-study-editor | 導入事例記事の文脈補足編集を実行（脱落語句の補完） |

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
│   ├── pr-director.md          # 「PRよろ」エントリーポイント（オーケストレーター）
│   ├── Review/                 # 導入事例記事系
│   │   ├── case-study-pipeline.md
│   │   ├── case-study-reviewer.md
│   │   └── case-study-editor.md
│   ├── planning/               # 企画系（interview系）
│   ├── writing/                # ライティング系（manuscript・press-release系）
│   ├── ops/                    # 業務オペレーション系
│   └── internal/               # 社内向け
├── rules/
│   └── global-notation.md      # 全エージェント共通の表記レギュレーション（自動適用）
├── skills/
│   ├── shared/                 # 全エージェント共通（表記DB・Markdownルール）
│   ├── case-study/             # 導入事例記事スキル
│   ├── interview/              # インタビュー企画スキル
│   ├── manuscript-writing/     # 原稿ライティングスキル
│   ├── press-release/          # プレスリリーススキル
│   └── owned-media-planning/   # オウンドメディア企画スキル
├── templates/
│   └── global-claude.md        # ~/.claude/CLAUDE.md のテンプレート
├── .claude/
│   └── settings.json           # プロジェクト起動時の自動セットアップフック
├── AGENTS.md
├── CLAUDE.md
├── README.md
└── setup.sh
```

**設計方針:**
- `agents/` = 「誰が・何をするか」（Role・Workflow）
- `skills/` = 「何を基準に動くか」（品質基準・表記DB・テンプレート）
- `rules/` = 「常に守るべきルール」（全エージェントに自動適用）

---

## 6. エージェントを編集したとき

GitHub 上で `agents/**/*.md` を編集した後:

- **自動同期設定済みの場合** → Claude Code を再起動するだけ
- **手動の場合** → `~/cowork-agents/setup.sh` を再実行

---

## 7. ベースシステム

[everything-claude-code](https://github.com/disler/everything-claude-code) をベースに構築
