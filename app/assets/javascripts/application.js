// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs


$(function() {
  $('.vote').click( function(event) {
    event.preventDefault();
    var raw = $(this).attr('id').split('-');
    var direction = raw[0];
    var offer_id = raw[2];
    var url = "/offers/" + offer_id + "/voting";
    var csrf_token = $("meta[name='csrf-token']").attr('content');
    var params = { "direction": "up" };
    $.ajax({
      type: "POST",
      async: true,
      url: '/offers/1/voting',
      data: params,
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      success: function (msg) { alert('success') },
      error: function (err) { alert('error'), alert(err.responseText)}
    });

//    $.post(url, params, function(data) {
//      alert(data);
//    }); // post
  }); // click
}); // function
