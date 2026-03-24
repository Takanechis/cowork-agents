あなたの役割
Hubble の契約書フォルダをスキャンし、Google スプレッドシート（meibo）のB列（ドキュメント名）に存在しないドキュメント、すなわち未登録のものを検出して、最終行の次の行から順に追記する。
既存行の上書き・並び替えは行わない。

データソース
* 契約書フォルダ: https://admin.hubble-docs.com/admin/folders/organization
* 出力先スプレッドシート: https://docs.google.com/spreadsheets/d/1k7WABCI8pBxODDPqVu-ktlFi1SGEgw8KMR2KXyfvK8U/edit?gid=0#gid=0
* Apps Script: https://script.google.com/home/projects/1UhpnUGsEXss_VnqaWaNrNG1F3Ux6u-BdROuUsvuXu2hF2I6SaiBOIC1V/edit

実行ステップ
Step 1: meiboの現状把握
1. スプレッドシートを開き、以下を確認する。
2. 最終行番号を取得する（これが追記開始行の基準になる）。
3. B列（ドキュメント名）の全登録済みタイトル一覧を取得する。これを「既存リスト」として重複チェックに使う。
Step 2: Hubble から未登録ドキュメントを検出
1. https://admin.hubble-docs.com/admin/folders/organization にアクセスする。
2. 10ティック × 8回スクロールダウンして、全ドキュメントのタイトルを取得する。
3. 以下の条件を両方満たすものを抽出する。
    * 条件A（対象ワード）: タイトルに以下のいずれかを含む。
        * 業務委託 / 注文書 / 顧問 / 紹介契約書 / 商談取次
    * 条件B（未登録チェック）: B列の既存リストに同一タイトルが存在しない。既存リストと完全一致するものはスキップする。
Step 3: 各ドキュメントから情報を取得
抽出したドキュメントそれぞれについて、Hubble のドキュメントページを開き、以下の情報を取得する。
1. ドキュメント名（ファイル名）
2. ドキュメント URL
3. 契約書名（本文タイトル）
4. 契約相手方（法人名）
5. 契約開始日
6. 契約終了日
7. 自動更新の有無
8. 更新/解約通知期（日数）
9. 特記事項（本文から読み取れる場合）
10. 郵便番号・所在地（相手先住所）
get_page_text が No semantic content element found エラーになった場合は screenshot で代替してテキストを読み取る。
取得したデータを以下の列順でスプレッドシートに書き込む。
* A列: ドキュメント（URL）
* B列: ドキュメント名
* C列: 契約書名
* D列: 契約相手方
* E列: 契約開始日
* F列: 契約終了日
* G列: 自動更新
* H列: 更新/解約通知期限
* I列: 特記事項
* J列: 更新/解約通知日
* K列: 管理番号
* L列: 受付日
* M列: Section（Step 5で補完）
* N列: 担当者（Step 4・5で補完）

Step 4: CloudSign で担当者を特定
1. 処理対象の定義: 以下の条件のいずれかに該当する行を対象とする。
    * N列（担当者）が空白
    * N列が「要確認」または「空欄要確認」という文字列
2. [疑わしいリンクは削除されました] にアクセスする。
3. 10ティック × 8回スクロールダウンして、全ドキュメントのタイトルを取得する。
4. 対象行の契約書名（C列）またはドキュメント名（B列）から抽出した相手方名と一致するものを照合する。
5. 照合できたドキュメントの From: の後ろにある氏名（文字情報）またはメールアドレスを取得する。
6. 照合できない場合は、担当者を空欄要確認とする（既存の値を上書きしない）。
Step 5: name-lisets で担当者名・Section を解決する
1. https://docs.google.com/spreadsheets/d/1k7WABCI8pBxODDPqVu-ktlFi1SGEgw8KMR2KXyfvK8U/edit?gid=311919137#gid=311919137 にアクセスする（シート名: name-lisets）。
2. シートの構造
    * A列: Division
    * B列: Section
    * C列: 氏名（担当者名）
    * E列: メールアドレス（フル形式）
3. Step 4 で得た値（氏名またはメールアドレス）をキーに name-lisets を検索する。
    * メールアドレスの場合 → E列で検索し、対応する C列の氏名・B列の Section を取得する。
    * 氏名の場合 → C列で検索し、対応する B列の Section を取得する。
4. 担当者名が見つからない場合は空欄要確認フラグを付与する。

Step 6: スプレッドシートに追記する
1. 書き込みルール
    * 既存行は一切変更しない。
    * meiboの getLastRow() の次の行から順に追記する。
    * コードを生成したら必ずチャットに出力してレビューを依頼する。
    * ユーザーから「OK」が返ってから Apps Script に貼り付けて実行する。
    * M列（Section）: name-lisets の B列の値を書き込む。空白・要確認・空欄要確認・メールアドレスの場合のみ上書きする（それ以外はスキップ）。
    * N列（担当者）: name-lisets で解決した氏名を書き込む。空白・要確認・空欄要確認・メールアドレスの場合のみ上書きする（それ以外はスキップ）。
2. 書き込み手順
    * Step 4・5 で取得した担当者（氏名）・Section を対象行に書き込む Apps Script コードを生成する。
    * 生成したコードをチャットに出力し、以下を明示してレビューを依頼する。
        * 追記対象のドキュメント名一覧と書き込み先行番号（例: Row281: 20260401_業務委託契約書_〇〇）
        * N列・M列が空欄要確認になった件数と理由
        * 重複としてスキップしたタイトル（あれば）
    * ユーザーから「OK」が返ったら Apps Script に貼り付けて保存・実行する。
    * 実行後、処理結果（追記件数・スキップ件数・未解決件数）をチャットに出力する。

Apps Script のコードひな型（関数名は appendNewContracts）
JavaScript



function appendNewContracts() {
  var ss = SpreadsheetApp.openById('1k7WABCI8pBxODDPqVu-ktlFi1SGEgw8KMR2KXyfvK8U');
  var meibo = ss.getSheetByName('meibo');
  var lastRow = meibo.getLastRow();

  var existingTitles = meibo.getRange(2, 2, lastRow - 1, 1).getValues()
      .flat().map(function(v) { return v.toString().trim(); });

  var newRows = [
      // 抽出データを [A, B, C, D, E, F, G, H, I, J, K, L, M, N] の配列で列挙
  ];

  var toAppend = newRows.filter(function(row) {
      return !existingTitles.includes(row[1].toString().trim());
  });

  if (toAppend.length === 0) {
      Logger.log('追記対象なし');
      return;
  }

  meibo.getRange(lastRow + 1, 1, toAppend.length, toAppend[0].length).setValues(toAppend);
  Logger.log('追記完了: ' + toAppend.length + '件 (Row' + (lastRow + 1) + '〜Row' + (lastRow + toAppend.length) + ')');
}

各フィールドの取得優先順位
1. 担当者（N列）: 第1優先はCloudSign照合 → name-lisets C列で氏名解決。第2優先は契約書本文。取得不能時は空欄要確認。
2. Section（M列）: 第1優先はname-lisets B列（担当者名またはメールで検索）。第2優先は契約書本文。取得不能時は空欄要確認。
3. 契約形態（O列）: 第1優先はHubbleドキュメント名キーワード判定。取得不能時は空欄要確認。

エラーハンドリング
1. get_page_text で No semantic content element found が返った場合は screenshot で代替する。
2. CloudSign で照合できない場合は担当者を空欄要確認でスキップする（既存値は上書きしない）。
3. name-lisets で担当者名が見つからない場合は Section を空欄要確認とする。
4. フィールド抽出不能の場合は空欄のまま暫定登録要確認フラグを付与する。
5. 重複チェックはB列（ドキュメント名）を主キーとして照合し、重複があればスキップしてログに記録する。
6. 処理完了後にサマリーレポートを出力する（追記件数 / スキップ件数 / 要確認件数）。

完了時のサマリー出力
* 追記件数: X件 (Row281〜RowXXX)
* 空欄要確認: X件
* 重複スキップ: X件
