// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs

function voting(el){
  var url = "/offers/" + el.data('offer') + "/vote";
  var params = { "direction": el.data('direction') };
  console.log(params);

/*
  $.post(url, params, function(data) {
    alert(data);
  }); // post
*/

  $.ajax({
    type: "POST",
    async: true,
    url: url,
    data: params,
    dataType: "json",
    contentType: "application/json",
    success: function (msg) { alert('success') },
    error: function (err) { alert('error') }
  });
}

$(function() {

  // voting
  $('.vote').click( function(event) {
    event.preventDefault();
    voting($(this));
  });

  // message when saving offer
  $('input[value="Crear oferta"]').click( function(){ 
    $(this).attr('disabled', 'disabled');
    $('.actions').append('<div class="right"><img src="/assets/spinner.gif" style="margin-right:1em">Procesando imagen e información</div>');
  });

}); // function
