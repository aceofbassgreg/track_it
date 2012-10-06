# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	
	new Highcharts.Chart
		chart: 
			renderTo: "activity_graph"
			type: 'column'

		exporting:
			buttons:
				printButton:
					enabled: true		

		title: 
			text: 'Statistics'
			
		xAxis:
			title:
				text: 'time frame'
					
			type: 'datetime'
			dateTimeLabelFormats:
				day: '%b %e'
		
		yAxis:
			title:
				text: 'Minutes'
		
		series: [
			name: $('#activity_graph').data('name')
			data: $('#activity_graph').data('minutes')
			pointStart: Date.UTC(
				$('#activity_graph').data('year')
				$('#activity_graph').data('month')
				$('#activity_graph').data('day')
			)
			pointInterval: 24 * 3600 * 1000
		]
	
############################################
		
	$('#start_time').datepicker
		dateFormat: 'yy-mm-dd'
	$('#end_time').datepicker
		dateFormat: 'yy-mm-dd'
	
	 # $('#start_date').datepicker(format: 'yy-mm-dd') take a look at this as well 
	
#################################
	

	# Create two variable with the names of the months and days in an array
	 monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	 dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

	 # Create a newDate() object
	 newDate = new Date()

	 # Extract the current date from Date object
	 newDate.setDate newDate.getDate()

	 # Output the day, date, month and year   
	 $("#Date").html dayNames[newDate.getDay()] + " " + newDate.getDate() + " " + monthNames[newDate.getMonth()] + " " + newDate.getFullYear()
	 setInterval (->

	   # Create a newDate() object and extract the seconds of the current time on the visitor's
	   seconds = new Date().getSeconds()

	   # Add a leading zero to seconds value
	   $("#sec").html ((if seconds < 10 then "0" else "")) + seconds
	 ), 1000
	 setInterval (->

	   # Create a newDate() object and extract the minutes of the current time on the visitor's
	   minutes = new Date().getMinutes()

	   # Add a leading zero to the minutes value
	   $("#min").html ((if minutes < 10 then "0" else "")) + minutes
	 ), 1000
	 setInterval (->

	   # Create a newDate() object and extract the hours of the current time on the visitor's
	   hours = new Date().getHours()

	   # Add a leading zero to the hours value
	   $("#hours").html ((if hours < 10 then "0" else "")) + hours
	 ), 1000

