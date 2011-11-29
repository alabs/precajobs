// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// FIXME: this doesn't seem to work
$("body").bind("ajaxSend", function(elm, xhr, s){
  var csrf_token = $("meta[name='csrf-token']").attr('content');
  if (s.type == "POST") {
    xhr.setRequestHeader('X-CSRF-Token', csrf_token);
  }
}); // bind

$(function() {
  $('.vote').click( function(event) {
    event.preventDefault();
    var raw = $(this).attr('id').split('-');
    var direction = raw[0];
    var offer_id = raw[2];
    var url = "/offers/" + offer_id + "/voting";
    var params = { direction: direction };
    $.post(url, params, function(data) {
      console.log('fucker');
      console.log(data.result);
    }); // post
  }); // click
}); // function
