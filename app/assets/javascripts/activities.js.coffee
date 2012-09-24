# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	Morris.Line
		element: 'activity_graph'
		data: $('#activity_graph').data('time-tracker-graph')
		xkey: 'date'
		ykeys: ['total_time']
		labels: ['Minutes']
		ymax: 'auto'
		ymin: 0