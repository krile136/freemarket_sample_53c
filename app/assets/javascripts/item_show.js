$(document).on("turbolinks:load", function () {
  $("#image_list img").hover(function () {
    if (!$(this).hasClass("image-skip")) {
      $("#item-show-top img").attr("src", $(this).attr("src"));
    }
  });
}); 