$(document).on('turbolinks:load', function () {
  //ユーザーの誕生日の閏年をjQueryで判断する
  // 誕生日の配列を宣言
  var birth_year = [];
  var birth_month = [];
  var months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  var date = new Date();
  var this_year = date.getFullYear();
  var oldest_year = 1900;

  // 誕生年月の配列を自動生成
  for (var i = this_year; i >= oldest_year; i--) {
    var year = { var: i, txt: String(i) };
    birth_year.push(year);
  }
  for (var i = 1; i <= 12; i++) {
    var month = { var: i, txt: String(i) };
    birth_month.push(month);
  }
  // hamlに配列内容を反映させる
  for (var i = 0; i < birth_year.length; i++) {
    $("<option>", {
      value: birth_year[i].var,
      text: birth_year[i].txt
    }).appendTo('#check_birth_year');
  }
  for (var i = 0; i < birth_month.length; i++) {
    $("<option>", {
      value: birth_month[i].var,
      text: birth_month[i].txt
    }).appendTo('#check_birth_month');
  }

  // 年、もしくは月のセレクトボックスの中身に変更があったら日の内容を変更する
  $('#check_birth_year, #check_birth_month').change(function () {
    $('#check_birth_day').empty();
    $("<option>", {
      text: '--'
    }).appendTo('#check_birth_day');
    months[1] = 28;
    var year = $('#check_birth_year').val();
    var month = $("#check_birth_month").val();
    if (year != '--' && month != '--') {
      if (month == 2) {
        if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
          months[1] = 29;
        }
      }
      var birth_day = []
      for (var i = 1; i <= months[month - 1]; i++) {
        var day = { var: i, txt: String(i) };
        birth_day.push(day);
      }
      for (var i = 0; i < birth_day.length; i++) {
        $("<option>", {
          value: birth_day[i].var,
          text: birth_day[i].txt
        }).appendTo('#check_birth_day');
      }
    }
  });

  // クレジットカードの有効期限を自動生成する
  var creditcard_limit_year = [];
  for (var i = (this_year + 11); i >= this_year; i--) {
    var year = { var: i, txt: String(i) };
    creditcard_limit_year.push(year);
  }
  for (var i = 0; i < creditcard_limit_year.length; i++) {
    $("<option>", {
      value: creditcard_limit_year[i].var,
      text: creditcard_limit_year[i].txt
    }).appendTo('#check_limit_year');
  }

  // 会員情報の「次へ進む」をクリックした時
  $('#user-info-registration').on("click", function () {
    // 各入力フィールドの名前のバリデーションチェック
    var false_numbers = 0;
    var check = {
      nickname: new RegExp(/./),
      mail_address: new RegExp(/^\S+@\S+\.\S+$/),
      password: new RegExp(/^[a-z\d]{7,100}$/i),
      password_confirmation: new RegExp(/^[a-z\d]{7,100}$/i),
      first_name: new RegExp(/^[一-龥ぁ-ん]/),
      last_name: new RegExp(/^[一-龥ぁ-ん]/),
      first_name_kana: new RegExp(/[\u30a0-\u30ff]/),
      last_name_kana: new RegExp(/[\u30a0-\u30ff]/),
      birth_year: new RegExp(/[0-9]{4,}/),
      birth_month: new RegExp(/[1-9]|[1-9][0-9]/),
      birth_day: new RegExp(/[1-9]|[1-9][0-9]/)
    }
    for (var key in check) {
      var checked_id = '#check_' + key;
      var alert_id = '#alert_' + key;
      $(alert_id).css('display', 'none');
      if (check[key].test($(checked_id).val()) == false) {
        false_numbers += 1;
        $(alert_id).css('display', 'block');
      }
    }

    // パスワードの一致のバリデーションチェック
    $('#alert_password_confirmation_same').css('display', 'none');
    if ($('#check_password_confirmation').val() != $('#check_password').val()) {
      $('#alert_password_confirmation_same').css('display', 'block');
      false_numbers += 1;
    }

    // 一つもバリデーションエラーがない場合、次へ進む
    if (false_numbers == 0) {
      // 会員情報登録の内容を非表示
      $('#member-information').css('display', 'none');
      // プログレスバーの色を変更
      $('#through .progress-status_bar').css('background', '#ea352d');
      $('#active').css('color', '#ea352d');
      $('#active .progress-status').css('background', '#ea352d');
      // 電話番号確認画面の表示
      $('#registration-title').text("電話番号の確認");
      $('#confirm-phone-number').css('display', 'block');
    }
    $(window).scrollTop(0);
  });

  // 携帯電話番号の確認で、SMSを送信するを押した時に実行
  $('#user-phone-registration').on("click", function () {
    var false_numbers = 0;
    var check = {
      phone: new RegExp(/[0-9]/),
    }
    for (var key in check) {
      var checked_id = '#check_' + key;
      var alert_id = '#alert_' + key;
      $(alert_id).css('display', 'none');
      if (check[key].test($(checked_id).val()) == false) {
        false_numbers += 1;
        $(alert_id).css('display', 'block');
      }
    }

    if (false_numbers == 0) {
      $('#confirm-phone-number').css('display', 'none');
      $('#registration-title').text("電話番号認証");
      $('#phone-number-authentication').css('display', 'block');
    }
    $(window).scrollTop(0);
  });

  $('#user-phone-authentication').on("click", function () {
    $('#phone-number-authentication').css('display', 'none');
    $('#registration-title').text("発送元・お届け先住所入力");
    $('#active .progress-status_bar').css('background', '#ea352d');
    $('#address').css('color', '#ea352d');
    $('#address .progress-status').css('background', '#ea352d');
    $('#input-address').css('display', 'block');
    $(window).scrollTop(0);
  });

  $('#user-address-input').on("click", function () {
    var false_numbers = 0;
    var check = {
      delivery_last_name: new RegExp(/^[一-龥ぁ-ん]/),
      delivery_first_name: new RegExp(/^[一-龥ぁ-ん]/),
      delivery_last_name_kana: new RegExp(/[\u30a0-\u30ff]/),
      delivery_first_name_kana: new RegExp(/[\u30a0-\u30ff]/),
      delivery_postal_code: new RegExp(/\d{3}[-]\d{4}/),
      prefecture: new RegExp(/[1-9]|[1-9][0-9]/),
      delivery_city: new RegExp(/./),
      delivery_address: new RegExp(/./),
    }

    for (var key in check) {
      var checked_id = '#check_' + key;
      var alert_id = '#alert_' + key;
      $(alert_id).css('display', 'none');
      if (check[key].test($(checked_id).val()) == false) {
        false_numbers += 1;
        $(alert_id).css('display', 'block');
      }
    }

    if (false_numbers == 0) {
      $('#input-address').css('display', 'none');
      $('#registration-title').text("支払い方法");
      $('#address .progress-status_bar').css('background', '#ea352d');
      $('#payment').css('color', '#ea352d');
      $('#payment .progress-status').css('background', '#ea352d');
      $('#input-payment').css('display', 'block');
    }
    $(window).scrollTop(0);
  });

  var prevent_submit = true;
  // submitのボタン押された時、実行
  $('#').click('submit', function (e) {
    if (prevent_submit) {
      // submitの動作を止める
      e.preventDefault();
      // 各フォームをチェックする
      var false_numbers = 0;
      var check = {
        credit_number: new RegExp(/(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})/),
        limit_month: new RegExp(/[1-9]|[1-9][0-9]/),
        limit_year: new RegExp(/[1-9]|[1-9][0-9]/),
        security_number: new RegExp(/[0-9]{3,4}/)
      }
      for (var key in check) {
        var checked_id = '#check_' + key;
        var alert_id = '#alert_' + key;
        $(alert_id).css('display', 'none');
        if (check[key].test($(checked_id).val()) == false) {
          false_numbers += 1;
          $(alert_id).css('display', 'block');
        }
      }
      // 一つもバリデーションエラーがない場合、prevnet_submitをfalse（上の処理が実行されなくなる）、submitを押したことにする
      if (false_numbers == 0) {
        prevent_submit = false;
        $(this).trigger('click');
      };
    };
  });
});