$(document).ready(function() {

$('#tweetField').keyup(function () {
  var max = 240;
  var len = $(this).val().length;
  if (len >= max) {
    $('#counter').text('Character count reached');
  } else {
    var char = max - len;
    $('#counter').text(char + ' characters left');
  }
});

});

