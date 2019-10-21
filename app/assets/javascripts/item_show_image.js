$(document).on("turbolinks:load",function(){
  $("#image-list img").hover(function(){
    $(".item-box__main--photo--img").attr("src",$(this).attr("src"));
  });
});