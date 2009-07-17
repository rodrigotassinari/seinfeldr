// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function prepare_and_submit_vote_form(winner, loser, key) {
  var div = (key == '1' ? '#voteA' : '#voteB')
  $(div).effect("highlight");
  $('#votes form#new_vote #vote_winner_id').attr('value', winner)
  $('#votes form#new_vote #vote_loser_id').attr('value', loser)
  $('#votes form#new_vote').submit();
  $('body > div.container_16').fadeTo('fast', 0.33);
  $('#loading').show();
}

$(document).ready(function($) {

  // binds '3' to calling the 'try another' link
  $(document).bind('keydown', '3', function (event){
    $('#try_another').effect("highlight");
    window.location = $('#try_another').attr('href');
    return false;
  });

})
