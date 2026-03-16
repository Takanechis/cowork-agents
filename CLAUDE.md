# アトミックソフトウェア CoWork エージェント

## プロジェクト概要
アトミックソフトウェア株式会社の3業務を自動化するCoWork環境。
ECCプラグイン(everything-claude-code)をベースに、業務特化の3エージェントを統合。

## 3つのエージェント

### @manuscript-writer — 原稿ライティング
音声データ（文字起こし済み）を受け取り、学習済みルールに基づいて原稿を自動生成する。
- 媒体別テンプレート対応（プレスリリース、ブログ、メルマガ等）
- - ボイス定義に基づくトーン&マナーの統一
  - - 医療・ヘルスケア業界用語ガイドライン準拠
   
    - ### @contract-miner — 契約データマイニング＆DB化
    - Hubble（app.hubble-docs.com）から契約書を取得・解析し、NotionデータベースにDB化する。
    - - 契約書名・日付・種別・相手先・期間・金額等を構造化抽出
      - - Notion DB（業務委託/パートナーデータベース）への自動登録
        - - 重複チェック・ステータス管理
         
          - ### @web-builder — Webサイト構築
          - corporate.v4（WordPress + Tailwind CSS）の保守運用・新規ページ作成。
          - - ブランチ運用: feature/* → test → prod（PRマージで自動デプロイ）
            - - 技術スタック: WordPress / Tailwind CSS v3 / GSAP / Splide
              - - サーバー: Amazon Linux 2023 / PHP 8.4 / MariaDB 11.8 / Nginx

              ## 共通ルール
              - 日本語で応答すること
              - - 作業ログは必ず残すこと
                - - 不明点は確認してから進めること
                  - - コミットメッセージは conventional commits 準拠（日本語可）
                   
                    - ## MCP サーバー構成
                    - - github: リポジトリ操作（corporate.v4 のPR作成、コードレビュー等）
                      - - notion: 契約管理DBへの書き込み
                        - - memory: セッション間の記憶保持
                          - - filesystem: ローカルファイル操作
                           
                            - ## 参照リポジトリ
                            - - ECCベース: https://github.com/affaan-m/everything-claude-code
                              - - Webサイト: https://github.com/medical-force/corporate.v4 (test ブランチ)
                                - - 契約データ: https://app.hubble-docs.com/folders/xAKNO4Mf6WrAylMY
                                  - - 契約DB: Notion 業務委託/パートナーデータベース
