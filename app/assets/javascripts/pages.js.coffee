# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  text_max = 140
  $("#textarea_counter").html text_max + " characters remaining"
  $("#micropost_content").keyup ->
    text_length = $("#micropost_content").val().length
    text_remaining = text_max - text_length
    $("#textarea_counter").html text_remaining +
    if (text_remaining == 1)
    	" character remaining"
    else
    	" characters remaining"
    return

  return
