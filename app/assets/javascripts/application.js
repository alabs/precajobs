// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs
//= require jquery.jgrowl

function voting(el){
  // vote for an offer and show result
  var offer_id = el.data('offer');
  var url = "/offers/" + offer_id + "/vote";
  var params = { "direction": el.data('direction') };
  $.post(url, params, function(data) {
    if (data.result == "OK"){
      $('.votes-count[data-offer="' + offer_id + '"]').html(data.votes)
    }
  });
}

function check_link_domain(el){
  // show all fields when the domain is unknown
  var link = el.val();
  if (link.search('infojobs') == -1){
    $('.clearfix.tohide').show('slow')
  } else {
    $('.clearfix.tohide').hide('slow')
  }

  // focusout check the URL 
  $.get('/validator/url', {'to_verify': link}, function(data){
    switch (data.status) { 
      case "OK": 
        $('#ko').hide('slow');
        $('#ok').show('slow');
        $('input[value="Crear oferta"]').removeAttr('disabled');
        break;
      case "haveit": 
        $('#ok').hide('slow');
        $('#ko').show('slow');
        $('input[value="Crear oferta"]').attr('disabled', 'disabled');
        $('#haveit').show('slow');
        break;
      default:
        $('#ok').hide('slow');
        $('#ko').show('slow');
        $('input[value="Crear oferta"]').attr('disabled', 'disabled');
        break;
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
    // if not summary, don't do nothing
    if (!$("#offer_summary").val() == ""){
      $(this).attr('disabled', 'disabled');
      $('#loading').show('slow');
    }
  });

  // check the input link domain
  $('input#offer_link').focusout( function() {
    check_link_domain($(this));
  });

  $(".flash-messages").each(function() {
    var msg = $(this).children("p");
    var theme = $(this).children("p").attr("class");
    $.jGrowl(msg.text(), { 
      sticky: true, 
      theme: "flash-" + theme,
      open: function() { 
        $(this).click( 
          function(){ 
            $(this).fadeOut();
          } 
        )
      }
    });
  });

});

