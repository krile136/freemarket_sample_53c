$(document).on('turbolinks:load', function () {
  $('#registration_one').on("click", function () {
    $('#member-information').css('display', 'none');
    $('#through .progress-status_bar').css('background', '#ea352d');
    $('#active').css('color', '#ea352d');
    $('#active .progress-status').css('background', '#ea352d');
    $('#registration-title').text("電話番号の確認");
  });
});