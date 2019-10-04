$(document).on('turbolinks:load', function () {
  //ユーザーの誕生日の閏年をjQueryで判断する
  // 誕生日の配列を宣言
  var birth_year = [];
  var birth_month = [];
  var months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // 誕生年月の配列を自動生成
  for (var i = 2019; i >= 1900; i--) {
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
    }).appendTo('#select_birth_year');
  }
  for (var i = 0; i < birth_month.length; i++) {
    $("<option>", {
      value: birth_month[i].var,
      text: birth_month[i].txt
    }).appendTo('#select_birth_month');
  }

  // 年、もしくは月のセレクトボックスの中身に変更があったら日の内容を変更する
  $('#select_birth_year, #select_birth_month').change(function () {
    $('#select_birth_day').empty();
    $("<option>", {
      text: '--'
    }).appendTo('#select_birth_day');
    months[1] = 28;
    var year = $('#select_birth_year').val();
    var month = $("#select_birth_month").val();
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
        }).appendTo('#select_birth_day');
      }
    }
  });

  // クレジットカードの有効期限を自動生成する
  var creditcard_limit_year = [];
  var date = new Date();
  var this_year = date.getFullYear();
  for (var i = (this_year + 11); i >= this_year; i--) {
    var year = { var: i, txt: String(i) };
    creditcard_limit_year.push(year);
  }
  for (var i = 0; i < creditcard_limit_year.length; i++) {
    $("<option>", {
      value: creditcard_limit_year[i].var,
      text: creditcard_limit_year[i].txt
    }).appendTo('#select_year_limit');
  }

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
    $(window).scrollTop(0);
  });

  $('#user-phone-registration').on("click", function () {
    $('#confirm-phone-number').css('display', 'none');
    $('#registration-title').text("電話番号認証");
    $('#phone-number-authentication').css('display', 'block');
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
  })

  $('#user-address-input').on("click", function () {
    $('#input-address').css('display', 'none');
    $('#registration-title').text("支払い方法");
    $('#address .progress-status_bar').css('background', '#ea352d');
    $('#payment').css('color', '#ea352d');
    $('#payment .progress-status').css('background', '#ea352d');
    $('#input-payment').css('display', 'block');
    $(window).scrollTop(0);
  })
});