# CoWork Agents

あらゆるタスクを実行する際に、このリポジトリ配下のエージェントを参照すること。

## エージェント一覧

### Writing（ライティング系）

@manuscript-writer (agents/writing/manuscript-writer.md)
原稿ライティング専門。音声データから原稿を自動生成する。
カテゴリ: インタビュー / メール（社外） / チャットメッセージ

@manuscript-reviewer (agents/writing/manuscript-reviewer.md)
原稿レビュー専門。manuscript-writer が生成した原稿の表記・トンマナ・構成を多角的にチェックし、Go / Rework 判定を行う。

@interview-writer (agents/writing/interview-writer.md)
企業情報を入力すると、Webリサーチ → 深堀りポイント洗い出し → インタビュー企画書を自動生成する。

@interview-reviewer (agents/writing/interview-reviewer.md)
interview-writer が生成したインタビュー企画書をレビューし、Go / Rework 判定を行う。

@press-release-writer (agents/writing/press-release-writer.md)
プレスリリースの企画→完成原稿を一気通貫で生成する。skills/press-release/ のスキルファイルを参照。

@press-release-reviewer (agents/writing/press-release-reviewer.md)
プレスリリース原稿のレビュー・Go判定。skills/press-release/SKILL.md の品質ゲートを基準にレビューする。

### Planning（企画・メディア系）

@owned-media-planner (agents/planning/owned-media-planner.md)
オウンドメディア（note）向けインタビュー企画書を生成する。ヒアリングメモを受け取り、企画タイトル案・企画骨子・企画概要を出力する。

### Ops（業務オペレーション系）

@contract-miner (agents/ops/contract-miner.md)
契約データマイニング＆DB化。Hubbleから契約書を解析しNotionにDB化する。

@web-builder (agents/ops/web-builder.md)
Webサイト構築。corporate.v4の保守運用・新規ページ作成を担当する。

### Internal（社内向け）

@communication-branding (agents/internal/communication-branding.md)
デザインシステムの作成と保守運用。SmartHR Design Systemをベンチマークとし、ブランド一貫性を実現する。

@new-graduate (agents/internal/new-graduate.md)
新卒・新入社員向けサポートエージェント。

---

## MD ファイル編集ルール

.md ファイルを編集・作成してコミットする前に、必ず以下を実施すること。

1. skills/shared/regulation-notation.md の「Markdown フォーマットルール」を参照する
2. 編集内容が各ルールに違反していないか1項目ずつ精査する
3. 違反箇所があれば、コミット前に修正する
4. 違反がないことを確認してからコミットする

## ベースシステム

ECCプラグイン: https://github.com/affaan-m/everything-claude-code
