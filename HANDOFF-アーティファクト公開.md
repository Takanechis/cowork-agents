# 引き継ぎ: medicalforce サイトツリー アーティファクト公開

公開ツール（Artifact）が有効な新しいセッションへ渡すための引き継ぎメモです。
最新版HTMLを新規アーティファクトとして公開する、または既存アーティファクトを最新版へ更新するための手順をまとめています。

## 現状（2026-06-24 時点）

- 最新版（正）: `/Users/takanechisato/cowork-agents/sitetree-artifact.html`（61,709バイト）
- 崩れ版バックアップ: `/Users/takanechisato/cowork-agents/sitetree-artifact.broken-backup-20260623.html`
- Desktop 同内容: `/Users/takanechisato/Desktop/medical-force_サイトツリー_編集共有版.html`（最新版と同一バイト）
- 注意: 旧 `~/Claude/cowork-agents`（シンボリックリンク）は現在存在しない。正準フォルダは `~/cowork-agents`。

## 今回の復元（なぜ・何を）

- 崩れの原因: 直前のアーティファクト（56,993バイト）で、＋ボタンやグリップなどのHTMLエンティティ（`&#xFF0B;`、`&#10303;` ほか）が文字列のまま表示される二重エスケープ不具合が発生。タブ機能、`asisVer`、`/case/` 配下のパスも欠落していた。
- 対応: 機能の揃った完全版（Desktop版・61,709バイト）を `sitetree-artifact.html` に復元。崩れ版はバックアップとして保存。
- 検証: ローカル描画で ＋ボタン、グリップ「⠿」、開閉「▼」が正常表示、エンティティ漏れ 0 件を確認。ASIS 導入事例の `/case_cat/`、`/case_service/`、`/case_issue/` を service.medical-force.com のサイトマップと全件照合し一致を確認。

## 最新版の内容（要点）

- 3タブ構成（ASIS／TOBE／リンク構造）。
- ツリーは名前の直接編集、子追加と弟追加、削除、ドラッグ並べ替え、親子の付け替え、折りたたみに対応。
- 各ノードに「パス」入力と「キーワード」複数入力（ASIS は流入KW、TOBE は狙うKW）。
- 導入事例（`/case/`）配下の3軸をタブ扱い（URLなし）で配置。軸は「キーワードで探す」「利用サービスで探す」「課題で探す」。各タブ配下に実パスを格納。
- 注釈レイヤー（文字、ペン、線、矢印、四角、丸、消しゴム、選択、戻す進む。タブごとに自動保存）。JSON 書き出し読み込み、PDF 出力に対応。
- 絵文字は不使用。

## 公開手順（新セッション・公開ツールが有効な状態）

1. 任意で品質チェック。`<script>` を node --check、SVG を xmllint で確認。
2. Artifact ツールに次を渡す。`file_path` = `/Users/takanechisato/cowork-agents/sitetree-artifact.html`、`favicon` = 🗺️。
3. 公開後、共有リンク（URL）を共有する。
4. 既存アーティファクト（version 6）https://claude.ai/code/artifact/f64e9422-4c29-4ae0-9a9a-08e189637d86 を最新版へ更新する場合は、同じ `file_path` で再公開すれば同一URLが更新される。

## 前提（維持すること）

- 単一HTML、ノービルド、外部依存なし、CSP安全。
- localStorage キー。ツリーは `mf_sitetree_artifact_v1`（`ASIS_VER=3`）、注釈は `mf_sitetree_anno_asis`、`mf_sitetree_anno_tobe`、`mf_sitetree_anno_link`。

## 新セッションに貼り付けるブロック（ここから下をコピー）

サイトツリー編集アーティファクトを最新版で公開してほしい。

やってほしいこと。`/Users/takanechisato/cowork-agents/sitetree-artifact.html` を、claude.ai の新しいアーティファクトとして公開して。Artifact ツールに `file_path` = このHTML、`favicon` = 🗺️ を渡すだけ。公開後、共有リンク(URL)を教えて。

背景。これは service.medical-force.com のIA検討ツール（単一の自己完結HTML、外部通信なし、CSP安全）。最新版は3タブ（ASIS／TOBE／リンク構造）。導入事例(/case/)配下は3軸をタブ扱い(URLなし)で配置し、ASIS の /case_cat/ /case_service/ /case_issue/ パスはライブのサイトマップと照合済み。直前のアーティファクトはHTMLエンティティが文字化けしてレイアウトが崩れていたため、完全版に復元してある。

既存アーティファクト https://claude.ai/code/artifact/f64e9422-4c29-4ae0-9a9a-08e189637d86 は version 6 で止まっている。同じ最新版で更新するなら同じ file_path で再公開すれば同一URLが更新される。

前提。単一HTML、ノービルド、外部依存なし、CSP安全を維持。localStorage キーはツリー `mf_sitetree_artifact_v1`（ASIS_VER=3）、注釈 `mf_sitetree_anno_asis` `_tobe` `_link`。

## 貼り付けブロックここまで
