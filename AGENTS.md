# CoWork Agents

あらゆるタスクを実行する際に、このリポジトリ配下のエージェントを参照すること。

## エージェント一覧

@manuscript-writer (agents/manuscript-writer.md)
原稿ライティング専門。音声データから原稿を自動生成する。
カテゴリ: インタビュー / メール（社外） / チャットメッセージ

@contract-miner (agents/contract-miner.md)
契約データマイニング＆DB化。Hubbleから契約書を解析しNotionにDB化する。

@web-builder (agents/web-builder.md)
Webサイト構築。corporate.v4の保守運用・新規ページ作成を担当する。

@communication-branding (agents/communication-branding.md)
デザインシステムの作成と保守運用。SmartHR Design Systemをベンチマークとし、ブランド一貫性を実現する。

@press-release-writer (agents/press-release-writer.md)
プレスリリースの企画→完成原稿を一気通貫で生成する。skills/press-release/ のスキルファイルを参照。

@press-release-reviewer (agents/press-release-reviewer.md)
プレスリリース原稿のレビュー・Go判定。skills/press-release/SKILL.md の品質ゲートを基準にレビューする。

@owned-media-planner (agents/owned-media-planner.md)
オウンドメディア（note）向けインタビュー企画書を生成する。ヒアリングメモを受け取り、企画タイトル案・企画骨子・企画概要を出力する。
対応企画種別: 部署の業務インタビュー

## MD ファイル編集ルール

.md ファイルを編集・作成してコミットする前に、必ず以下を実施すること。

1. agents/regulation-md-writing.md の全ルールを参照する
2. 編集内容が各ルールに違反していないか1項目ずつ精査する
3. 違反箇所があれば、コミット前に修正する
4. 違反がないことを確認してからコミットする

## ベースシステム

ECCプラグイン: https://github.com/affaan-m/everything-claude-code
