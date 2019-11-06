$(document).on('turbolinks:load', function () {
	$('.sell__image--select__ul--text').on('change', 'input[type="file"]', function (e) {

		var id = $(this).data('id'),
			file = e.target.files[0],
			reader = new FileReader(),
			$label = $(".ul--id--" + id),
			$li = $label.children('li')

		// 画像ファイル以外の場合は何もしない
		if (file.type.indexOf("image") < 0) {
			return false;
		}

		// ファイル読み込みが完了した際のイベント登録
		reader.onload = (function (file) {
			return function (e) {
				// liの中を削除する
				$li.empty();
				// 透過していた領域を表示する
				$label.css('opacity', '1');
				// 領域の中にロードした画像を表示するimageタグを追加
				$li.append($('<img>').attr({
					src: e.target.result,
					width: "114px",
					height: "116px",
					class: "preview",
					title: file.name,
				}));
				// 編集削除ボタンを表示する
				$('.btn-box').css('display', 'block');
			};
		})(file);

		reader.readAsDataURL(file);
	});

	// 削除ボタンを押した時
	$(".delete-btn").on("click", function () {
		$(this).parent().prev().empty();
		// 削除ボタンを押した時、inputの中身を空っぽにする
		$(this).parent().prev().prev()[0].value = "";
		$(this).prev('input[type=hidden]').val('1');
		console.log(this); 
		$(this).parent().parent().css('opacity', '0');
		return false;
	});

});