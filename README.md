# cowork-agents マニュアル

アトミックソフトウェア CoWork 用オリジナルエージェント

---

## AI編集部 運用フロー

AI編集部は、企画書づくりから原稿生成・校正までを、入口の editor エージェントと4羽の担当（カワセミ・ハシボソカラス・オオタカ・シジュウカラ）が分担して進める仕組みです。各自の Cowork（Claude Code）から呼び出して使います。

### 使い方

入口はひとつだけ。エージェント名を覚える必要はありません。

```
@editor 編集部よろ
```

編集部が「今日は何をしますか？」と選択肢を出すので、番号で答えます。

1. 企画を作る → カワセミ（企画担当）
2. 原稿を書く → ハシボソカラス（ライティング担当）
3. 原稿を校正する → オオタカ（校正担当）
4. 完成原稿をレビューして改善提案を出す → シジュウカラ（最終レビュー担当）

原稿ができたら「修正したい点はありますか？」と聞かれます。指摘するとシジュウカラが改善提案をPRにし、高根の承認後に全員へ反映されます。

### 共有のしかた

Cowork のプロジェクトそのものは共有できない（各自ローカル）ため、次のように分けて共有します。

| 対象 | 場所 |
|---|---|
| エージェント・スキル（品質基準） | GitHub cowork-agents（起動のたび自動同期） |
| 成果物（企画書・原稿） | Google Drive 共有ドライブ |
| 連絡・依頼の共有 | Slack #cp-pr-team-editorial |

### 2ロールの権限

| | 管理者（高根） | ユーザ |
|---|---|---|
| GitHub | 編集・PR承認・マージ | 閲覧・PR作成 |
| スキル（品質基準）の改変 | できる | PR提案まで |

スキルを書き換えられるのは高根だけです。ユーザーのフィードバックはPRとして届き、高根の承認後に全員へ反映されます。

### 入れてはいけない情報

患者・利用者の個人情報、社外秘の数字、ID・パスワードは渡さない。素材に含まれる場合は、その部分を消してから渡します。

### トラブル時

| 症状 | 確認すること |
|---|---|
| エージェントが見えない | Claude Code を再起動する（起動フックで自動同期されます） |
| 権限エラーが出る | GitHub招待の承認と、GitHub MCP接続を確認する |
| セットアップでつまずく | セットアップ伴走プロンプトをClaudeに貼ると1ステップずつ案内されます |

初回セットアップの詳しい手順は ONBOARDING.md を参照してください。

---

## 1. 初回セットアップ

このリポジトリは招待制（プライベート）です。GitHubアカウントと認証が必要です。
不安な場合は、セットアップ伴走プロンプト（SlackやNotionで配布）をClaudeに貼れば、1ステップずつ案内・代行してくれます。

手順の全体像:

```bash
# 1. GitHub にログイン（gh が無ければ Mac: brew install gh / Windows: winget install --id GitHub.cli）
gh auth login

# 2. リポジトリを取り込み、セットアップを実行
gh repo clone Takanechis/cowork-agents ~/cowork-agents
cd ~/cowork-agents && bash setup.sh
```

setup.sh が自動でやること:

- `~/.claude/agents/` にエージェントのシンボリックリンクを作成
- `~/.claude/CLAUDE.md` に編集部グローバル設定を配置
- Claude Code 起動時に自動 pull するフックを `~/.claude/settings.json` に追加

完了後、Claude Code を再起動してください。以降は起動のたびに最新のエージェントへ自動更新されます。

事前に、Slackの `#cp-pr-team-editorial` で高根にリポジトリへの招待を依頼し、GitHubの招待メールを承認しておく必要があります（詳細は ONBOARDING.md）。

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
