$(document).on('turbolinks:load', function () {
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

  // 「カテゴリーを探す」にホバーしたら親カテゴリーリストを表示
  $('.main-header__inner__nav__search__category').hover(function() {
    $('.main-header__inner__category-list__parent').show();
  }, function() {
    //  ホバーが外れた時、親カテゴリーリスト以外にカーソルが当たっていたら親カテゴリーリストを非表示
    if (searchElement(getHoverElements(), "main-header__inner__category-list") == false) {
      $('.main-header__inner__category-list__parent').hide();
    }
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