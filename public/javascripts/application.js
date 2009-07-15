// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function prepare_and_submit_vote_form(winner, loser) {
  $('#votes form#new_vote #vote_winner_id').attr('value', winner)
  $('#votes form#new_vote #vote_loser_id').attr('value', loser)
  $('#votes form#new_vote').submit();
}

$(document).ready(function($) {
  $('a[rel*=facebox]').facebox();
})
