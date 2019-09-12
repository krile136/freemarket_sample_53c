$(function() {

  // サードバーのリストのカーソルONで矢印を移動＆アクティブでないリストの矢印は色を変える
  $('.mypage-side__list').hover(function() {
    let targetArrow = $(this).find('.mypage-side__list__link__arrow');
    targetArrow.animate({'right':'11px'}, 'fast');
    if (!$(this).hasClass('mypage-side__list-active')) {
        targetArrow.css('color', '#333333');
    }
  },function() {
    let targetArrow = $(this).find('.mypage-side__list__link__arrow');
    targetArrow.animate({'right':'16px'}, 'fast');
    if (!$(this).hasClass('mypage-side__list-active')) {
      targetArrow.css('color', '#cccccc');
  }
  })

  // タブクリック時の表示切り替え処理
  $('.mypage-content__main__tablist__header__tab').on('click', function () {
    let clickedTab = $(this);

    // クリックしたタブがアクティブでない場合のみ処理続行
    if (!clickedTab.hasClass('mypage-content__main__tablist__header__tab-active')) {
      let pairTab = '';
      let shownList = '';
      let hiddenList = '';

      switch (clickedTab.attr('id')) {
        case 'mypage-notification-tab':
            pairTab = $('#mypage-todo-tab');
            shownList = $('#mypage-notification-list');
            hiddenList = $('#mypage-todo-list');
            break;
        case 'mypage-todo-tab':
            pairTab = $('#mypage-notification-tab');
            shownList = $('#mypage-todo-list');
            hiddenList = $('#mypage-notification-list');
            break;
        case 'mypage-purchase-tab':
            pairTab = $('#mypage-purchased-tab');
            shownList = $('#mypage-purchase-list');
            hiddenList = $('#mypage-purchased-list');
            break;
        case 'mypage-purchased-tab':
            pairTab = $('#mypage-purchase-tab');
            shownList = $('#mypage-purchased-list');
            hiddenList = $('#mypage-purchase-list');
      }
      // クリックしたタブをアクティブにする
      clickedTab.removeClass('mypage-content__main__tablist__header__tab-inactive');
      clickedTab.addClass('mypage-content__main__tablist__header__tab-active');;
      // クリックしたタブの隣のタブを非アクティブにする
      pairTab.removeClass('mypage-content__main__tablist__header__tab-active');
      pairTab.addClass('mypage-content__main__tablist__header__tab-inactive');
      // アクティブにしたタブ配下のリストを表示
      shownList.removeClass('mypage-content__main__tablist-inactive');
      // 非アクティブにしたタブ配下のリストを非表示
      hiddenList.addClass('mypage-content__main__tablist-inactive');
    }
  });
});