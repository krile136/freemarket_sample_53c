$(document).on('turbolinks:load', function() {
  $('input[type="submit"].confirm-buy__item__buy').click(function(e) {
    if (window.confirm('本当に購入して宜しいですか？') == false) {
			e.preventDefault();
		}
  });
});