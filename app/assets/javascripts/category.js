
$(document).on('turbolinks:load', function() {
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 親カテゴリー選択で子カテゴリーを生成
  $('#parent_category').change(function () {
    var parent_id = $('#parent_category option:selected').val();
    if (parent_id.length != 0){
      $('#category-child-1').removeClass('hide');
      $.ajax({
        url: '/items/get_category_children',
        type: 'Get',
        data: {parent_id: parent_id},
        dataType: 'json'
      }).done(function(children){
        $('#category-child-1 option').remove();
        $('#category-child-2 option').remove();
        var insertHTML = `<option value="">---</option>`;
        children.forEach(function(child){
          insertHTML += appendOption(child);
        })
        $('#child_category').append(insertHTML);
      }).fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      $('#category-child-1').addClass('hide');
      $('#category-child-2').addClass('hide');
    }
  });

  // 子カテゴリー選択で孫カテゴリー生成
  $('#child_category').change(function () {
    var child_id = $('#child_category option:selected').val();
    if (child_id.length != 0){
      $('#category-child-2').removeClass('hide');
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'Get',
        data: {child_id: child_id},
        dataType: 'json'
      }).done(function(grandchildren){
        $('#category-child-2 option').remove();
        var insertHTML = `<option value="">---</option>`;
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        })
        $('#grandchild_category').append(insertHTML);
      }).fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      $('#category-child-2').addClass('hide');
    }
  });

  //カーソルが当たっている要素(配列)を取得
  function getHoverElements() {
    return jQuery(":hover");
  }

  // カーソルが当たっている要素(配列)に指定のclass名の要素があるかチェック
  function searchElement(elementsArray, className) {
    let isExist = false;
    elementsArray.each(function() {
      if ($(this).hasClass(className)) {
        isExist = true;
      }
    });
    return isExist;
  }

  // 非同期で取得したカテゴリーリストを組み立て
  function appendChildrenCategoryHTML(children, targetCategory) {
    targetCategoryList = $('.main-header__inner__category-list__' + targetCategory);
    targetCategoryList.empty();
    let htmlArray = new Array();

    // 表示は最大14件
    for(i = 0; i < 14; i++) {
      // カテゴリーが14件に満たない場合は全件処理したらbreak
      if (i == children.length) break;

      let html = `<li class="main-header__inner__category-list__${targetCategory}__piece" data-category-id="${children[i].id}">
                    <a class="main-header__inner__category-list__${targetCategory}__piece__link" href="">${children[i].name}</a>
                  </li>`;
      htmlArray.push(html);
    };
    targetCategoryList.append(htmlArray.join('\n'));
    targetCategoryList.show();
  };

  // 「カテゴリーを探す」にホバーしたら親カテゴリーリストを表示
  $('.main-header__inner__nav__search__category').hover(function() {
    $('.main-header__inner__category-list__parent').show();
  }, function() {
    //  ホバーが外れた時、親カテゴリーリスト以外にカーソルが当たっていたら親カテゴリーリストを非表示
    if (searchElement(getHoverElements(), "main-header__inner__category-list") == false) {
      $('.main-header__inner__category-list__parent').hide();
    }
  });

  // 親or子カテゴリーにカーソルが当たったら子or孫カテゴリーを取得
  $(document).on('mouseenter', '.main-header__inner__category-list__parent__piece, .main-header__inner__category-list__child__piece', function() {
    // 親カテゴリーリスト最下の「カテゴリー一覧」の場合は子カテゴリーを空にして処理を抜ける
    if (searchElement(getHoverElements(), "main-header__inner__category-list__parent__piece--last") == true) {
      $('.main-header__inner__category-list__child').empty();
      return;
    };

    // カーソルが当たっているカテゴリーのIDを取得
    let categoryId = $(this).data('category-id');

    //イベント発火元が親か子か？→取得対象が子か孫か？
    let targetCategory = "";
    if ($(this).hasClass("main-header__inner__category-list__parent__piece")) {
      targetCategory = "child";
    } else {
      targetCategory = "grandchild";
    };

    $.ajax({
      type: "GET",
      url: "/children_category",
      data: {parent_id: categoryId},
      dataType: 'json'
    })
    .done(function(children){
      appendChildrenCategoryHTML(children, targetCategory);
    })
    .fail(function(){
      alert('カテゴリー取得に失敗しました');
    });
  });

  // 親カテゴリーリストのホバーが外れた時
  $('.main-header__inner__category-list__parent').mouseleave(function() {
    let hoverElements = getHoverElements();
    //「カテゴリーを探す」にカーソルが当たっている場合は子カテゴリーリストを非表示
    if (searchElement(hoverElements, "main-header__inner__nav__search__category") == true) {
      $('.main-header__inner__category-list__child').hide();
    } else if (searchElement(hoverElements, "main-header__inner__category-list") == false) {
      // カーソルがカテゴリーリストから外れたらすべてのリストを非表示
      $('.main-header__inner__category-list__parent').hide();
      $('.main-header__inner__category-list__child').hide();
    }
  });

  // 子カテゴリーリストのホバーが外れた時
  $('.main-header__inner__category-list__child').mouseleave(function() {
    let hoverElements = getHoverElements();
    // 親カテゴリーリストにカーソルが戻った場合は
    if (searchElement(hoverElements, "main-header__inner__category-list__parent") == true) {
      // 孫カテゴリーリスト非表示
      $('.main-header__inner__category-list__grandchild').hide();
      // 親カテゴリーの選択状態を解除
      $('.main-header__inner__category-list__parent__piece__link').removeClass('selected-parent');
    } else if (searchElement(hoverElements, "main-header__inner__category-list") == false) {
      // カーソルがカテゴリーリストから外れたらすべてのリストを非表示
      $('.main-header__inner__category-list__parent').hide();
      $('.main-header__inner__category-list__parent__piece__link').removeClass('selected-parent');
      $('.main-header__inner__category-list__child').hide();
      $('.main-header__inner__category-list__grandchild').hide();
    }
  });

  // 孫カテゴリーリストのホバーが外れた時
  $('.main-header__inner__category-list__grandchild').mouseleave(function() {
    // カーソルがカテゴリーリストから外れたらすべてのリストを非表示
    if (searchElement(getHoverElements(), "main-header__inner__category-list") == false) {
      $('.main-header__inner__category-list__parent').hide();
      $('.main-header__inner__category-list__parent__piece__link').removeClass('selected-parent');
      $('.main-header__inner__category-list__child').hide();
      $('.main-header__inner__category-list__child__piece__link').removeClass('selected-child');
      $('.main-header__inner__category-list__grandchild').hide();
    } else {
      // 子カテゴリーに戻った場合は子カテゴリーの選択状態を解除
      $('.main-header__inner__category-list__child__piece__link').removeClass('selected-child');
    }
  });

  // 親カテゴリーから子カテゴリーへ移動した時、親カテゴリーを選択状態のままにする
  $('.main-header__inner__category-list__parent__piece').mouseleave(function() {
    if (searchElement(getHoverElements(), "main-header__inner__category-list__child") == true) {
      $(this).children().addClass('selected-parent');
    }
  });

  // 子カテゴリーから孫カテゴリーへ移動した時、子カテゴリーを選択状態のままにする
  $(document).on('mouseleave', '.main-header__inner__category-list__child__piece', function() {
    if (searchElement(getHoverElements(), "main-header__inner__category-list__grandchild") == true) {
      $(this).children().addClass('selected-child');
    }
  });
});