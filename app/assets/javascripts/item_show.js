$(document).on("turbolinks:load", function () {
  $("#image_list img").hover(function () {
    $("#item-show-top img").attr("src", $(this).attr("src"));
  });
}); 