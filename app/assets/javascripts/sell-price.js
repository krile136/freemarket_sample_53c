$(document).on('turbolinks:load', function () {
  $("#item_price").on("keyup", function () {
    var price = $(this).val();
    var fee = Math.floor(price * 0.1);
    $(".sell__about__right__wrap__fee--right").text("¥ " + fee);
    var profit = price - fee
    $(".sell__about__right__wrap__profit--right").text("¥ " + profit);
  });

  $(window).on('load', function() {
  if ( document.URL.match(/^(?=.*items)(?=.*edit)/)){
    var price = $("#item_price").val();
    var fee = Math.floor(price * 0.1);
    $(".sell__about__right__wrap__fee--right").text("¥ " + fee);
    var profit = price - fee
    $(".sell__about__right__wrap__profit--right").text("¥ " + profit);
  } 
});
}); 