$(document).on('turbolinks:load', function () {
  // 会員情報の「次へ進む」をクリックした時
  $('#user-info-registration').on("click", function () {
    // 会員情報登録の内容を非表示
    $('#member-information').css('display', 'none');
    // プログレスバーの色を変更
    $('#through .progress-status_bar').css('background', '#ea352d');
    $('#active').css('color', '#ea352d');
    $('#active .progress-status').css('background', '#ea352d');
    // 電話番号確認画面の表示
    $('#registration-title').text("電話番号の確認");
    $('#confirm-phone-number').css('display', 'block');
  });

  $('#user-phone-registration').on("click", function () {
    // 電話番号確認ページの非表示
    $('#confirm-phone-number').css('display', 'none');
    // 電話番号認証画面の表示
    $('#registration-title').text("電話番号認証");
    $('#phone-number-authentication').css('display', 'block');
  });
});