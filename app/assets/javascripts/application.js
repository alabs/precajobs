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

function check_link_domain(el){
  // show all fields when the domain is unknown
  var link = el.val();
  if (link.search('infojobs') == -1){
    $('.clearfix.hidden').show('slow')
  } else {
    $('.clearfix.hidden').hide('slow')
  }

  // focusout check the URL 
  $.get('/validator/url', {'to_verify': link}, function(data){
    if (data.status) { 
      $('#ko').hide('slow');
      $('#ok').show('slow');
    } else {
      $('#ok').hide('slow');
      $('#ko').show('slow');
    }
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

  $('input#offer_link').focus();

  // check the input link domain
  $('input#offer_link').focusout( function() {
    check_link_domain($(this));
  });

}); // function
