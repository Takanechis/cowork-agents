# CoWork Agents

あらゆるタスクを実行する際に、このリポジトリ配下のエージェントを参照すること。

---

## エージェント一覧

### @manuscript-writer (agents/manuscript-writer.md)

原稿ライティング専門。音声データから原稿を自動生成する。
カテゴリ: インタビュー / メール（社外） / チャットメッセージ

### @contract-miner (agents/contract-miner.md)

契約データマイニング＆DB化。Hubbleから契約書を解析しNotionにDB化する。

### @web-builder (agents/web-builder.md)

Webサイト構築。corporate.v4の保守運用・新規ページ作成を担当する。

### @communication-branding (agents/communication-branding.md)

デザインシステムの作成と保守運用。SmartHR Design Systemをベンチマークとし、ブランド一貫性を実現する。

---

## MD ファイル編集ルール

`.md` ファイルを編集・作成してコミットする前に、必ず以下を実施すること。

1. `agents/regulation-md-writing.md` の全ルールを参照する
2. 編集内容が各ルールに違反していないか1項目ずつ精査する
3. 違反箇所があれば、コミット前に修正する
4. 違反がないことを確認してからコミットする

---

## ベースシステム

ECCプラグイン: https://github.com/affaan-m/everything-claude-code
