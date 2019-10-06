$(document).on('turbolinks:load', function() { 

    var delivery_methods = [
      {id: 1, name: '未定'}, {id: 2, name: 'らくらくメルカリ便'}, {id: 3, name: 'ゆうメール'}, {id: 4, name: 'レターパック'}, {id: 5, name: '普通郵便(定形、定形外)'}, {id: 6, name: 'クロネコヤマト'},
      {id: 7, name: 'ゆうパック'}, {id: 8, name: 'クリックポスト'}, {id: 9, name: 'ゆうパケット'}
    ]

    // 配送方法ボックスのオプションを作成
    function appendOption(method){
      var html = `<option value="${method.id}">${method.name}</option>`;
      return html;
    }

  // 配送料の負担を選択で配送方法を表示させる
    $('#paying-side-selection').change(function () {
      $('#delivery-method-box').removeClass('hide');
      $('#delivery-method-selection').empty();
      $("<option>", {
        text: '---'
      }).appendTo('#delivery-method-selection');
      var methods_id = $('#paying-side-selection').val();
      console.log(methods_id)
      if(methods_id == 0){
          $('#delivery-method-box').addClass('hide');
      }else if(methods_id == 1){
        for (var i = 0; i < 6; i++) {
          $("<option>", {
            value: delivery_methods[i].id,
            text: delivery_methods[i].name
          }).appendTo('#delivery-method-selection');
        }
      }else if(methods_id == 2){
        for (var i = 6; i < 9; i++) {
          $("<option>", {
            value: delivery_methods[i].id,
            text: delivery_methods[i].name
          }).appendTo('#delivery-method-selection');
        }
      }
    });
});


