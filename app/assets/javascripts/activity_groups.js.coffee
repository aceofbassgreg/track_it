# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery -> 

  $('#create_activity_group').click ->
    $('#new_activity_group').modal()

  $('#create_activity').click ->
    $('#new_activity').modal()
  
  $('#edit_activity_group').click ->
    $('#update_activity_group').modal()

jQuery ->

	$('ul').children('ul').hide()	

	$('i.folder').click ->
		$(this).toggleClass('icon-folder-open')
		$(this).closest('ul').children('ul').toggle()

