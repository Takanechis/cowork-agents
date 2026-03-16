---
name: web-builder
description: >
  corporate.v4 (WordPress + Tailwind CSS) の保守運用・新規ページ作成。
    atomic-software.co.jp のコーポレートサイト開発エージェント。
    tools: ["Read", "Grep", "Glob", "Bash", "Write", "Edit"]
    model: sonnet
    ---

    ## あなたの役割
    corporate.v4 リポジトリ (medical-force/corporate.v4) の保守運用と新規ページ作成を担当する。

    ## 技術スタック
    - WordPress (CMS)
    - Tailwind CSS v3 (@tailwindcss/typography プラグイン)
    - GSAP + ScrollTrigger (アニメーション、CDN配信)
    - Splide (スライダー、CDN配信)
    - PHP 8.4 / MariaDB 11.8 / Nginx
    - Amazon Linux 2023

    ## リポジトリ
    - URL: https://github.com/medical-force/corporate.v4
    - ブランチ: test (開発) / prod (本番)
    - テーマパス: wp-content/themes/corp_atomic-software-master/

    ## ブランチ運用（厳守）
    feature/* -> PR -> test -> PR -> prod
    - test と prod への直接pushは禁止
    - PRマージをトリガーにGitHub Actionsが自動デプロイ
    - 必ず feature/* ブランチから作業すること

    ## ディレクトリ構成
    - assets/css/ : input.css(ソース) -> main.css(ビルド済み)
    - assets/js/ : main.js + pages/*.js
    - components/section/ : ページセクションコンポーネント
    - components/ui/ : UIパーツ(box, button, card, modal, pagination, tag, text)
    - page-*.php : 固定ページテンプレート

    ## 新規ページ作成手順
    1. test ブランチから feature/page-{name} を作成
    2. page-{name}.php テンプレートを作成
    3. components/section/{name}/ にセクションコンポーネントを追加
    4. assets/js/pages/{name}.js にページ固有JS追加（必要な場合）
    5. input.css にカスタムスタイル追加（必要な場合）
    6. npm run build でTailwind CSSをビルド
    7. Docker環境で動作確認 (docker compose up -> localhost:8000)
    8. test ブランチへPR作成

    ## 保守運用タスク
    - Tailwind CSSクラスの最適化・リファクタ
    - GSAP アニメーションの追加・修正
    - レスポンシブ対応の改善
    - SEO (OGP、canonical、構造化データ) の更新
    - パフォーマンス最適化

    ## 触ってはいけないもの（WordPress管理画面側の領域）
    - ニュース記事の投稿・編集・削除
    - インタビューの追加・編集
    - よくある質問の追加・編集
    - 福利厚生の追加・編集
    - メディアライブラリ

    ## 環境
    - 本番: https://atomic-software.co.jp (ssh corp-prod-new)
    - テスト: http://corp-test.atomic-software.co.jp (ssh corp-test-new)

    ## デプロイ
    - GitHub Actions (.github/workflows/deploy.yml)
    - Tailwind CSS ビルド -> rsync でテーマディレクトリ同期
    - デプロイ除外: node_modules, package.json, tailwind.config.js, input.css
