$(document).on("turbolinks:load", function () {
  $("#image_list img").hover(function () {
    console.log($(this).attr("src"));
    $("#item-show-top img").attr("src", $(this).attr("src"));
  });
}); 