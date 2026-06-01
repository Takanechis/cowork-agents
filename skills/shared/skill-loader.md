---
skill: shared/skill-loader
version: 1.0
description: AI編集部の全エージェントが作業開始時に最初に読み込むインデックスファイル。記事種別ごとに「どのスキルファイルを・どの順番で読むか」を定義する。
used_by:
  - shijukara
  - otaka
  - hashiboso-karasu
  - kawasemi
updated: 2026-05
---

# スキルローダー: 読み込みインデックス

## 使い方

各エージェントは作業開始時に **必ずこのファイルを最初に Read すること**。
記事種別に対応するファイルリストを取得し、リスト全件を順番に Read してから作業を開始する。

読み込み完了後、内部で以下を確認してから次のステップへ進む。

```
読み込み完了確認:
- skill-loader.md: 済
- {記事種別スキルファイル}: 済（X件）
- regulation-notation.md: 済
```

---

## 記事種別 × スキルファイル マッピング

### owned-media-interview（オウンドメディア インタビュー記事）

| 担当エージェント | 読み込むファイル |
|---|---|
| カワセミ（企画） | skills/planning/owned-media-interview.md |
| ハシボソカラス（ライティング） | skills/writing/owned-media-interview.md |
| オオタカ（校正） | skills/proofreading/owned-media-interview.md |
| シジュウカラ（最終レビュー） | skills/writing/owned-media-interview.md, skills/proofreading/owned-media-interview.md |
| 全員共通 | skills/shared/regulation-notation.md |

### owned-media-dialogue（オウンドメディア 対談記事）

| 担当エージェント | 読み込むファイル |
|---|---|
| カワセミ（企画） | skills/planning/owned-media-dialogue.md |
| ハシボソカラス（ライティング） | skills/writing/owned-media-dialogue.md |
| オオタカ（校正） | skills/proofreading/owned-media-dialogue.md |
| シジュウカラ（最終レビュー） | skills/writing/owned-media-dialogue.md, skills/proofreading/owned-media-dialogue.md |
| 全員共通 | skills/shared/regulation-notation.md |

### entry（語りおろし 入社エントリ）

| 担当エージェント | 読み込むファイル |
|---|---|
| カワセミ（企画） | skills/planning/entry.md |
| ハシボソカラス（ライティング） | skills/writing/entry.md |
| オオタカ（校正） | skills/proofreading/entry.md |
| シジュウカラ（最終レビュー） | skills/writing/entry.md, skills/proofreading/entry.md |
| 全員共通 | skills/shared/regulation-notation.md |

### press-release（プレスリリース）

| 担当エージェント | 読み込むファイル |
|---|---|
| カワセミ（企画） | skills/planning/press-release.md |
| ハシボソカラス（ライティング） | skills/writing/press-release.md |
| オオタカ（校正） | skills/proofreading/press-release.md |
| シジュウカラ（最終レビュー） | skills/writing/press-release.md, skills/proofreading/press-release.md |
| 全員共通 | skills/shared/regulation-notation.md |

---

## 種別追加時の手順

新しい記事種別が増えた場合は、以下の手順でこのファイルを更新する。

1. 上記マッピングテーブルに新種別の行を追加する
2. 以下の3ディレクトリに対応するスキルファイルを新規作成する
  - skills/planning/{新種別}.md
  - skills/writing/{新種別}.md
  - skills/proofreading/{新種別}.md
3. 各エージェントの対応種別リストに追記する（agents/editorial/ 配下の各エージェントファイル）
4. AGENTS.md の種別一覧を更新する

---

## ロード確認ステップ（エージェントWorkflowへの組み込み方）

各エージェントのWorkflowの最初のステップに以下を組み込む。

```
## Step 0: スキルローダー読み込み

1. skills/shared/skill-loader.md を Read する
2. 記事種別に対応するファイルリストを取得する
3. リスト全件を順番に Read する
4. 「読み込み完了: X件」を確認してから Step 1 へ進む

読み込み漏れがある場合は作業を開始しない。
```
