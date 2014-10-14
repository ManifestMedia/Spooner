dev = true

Log = (value) ->
	if dev
		console.log value

# loader = (state) ->
# 	if state == "hide"
# 	  $('.loader').hide()
# 	  $('.shadow').css("opacity" , "1")
# 	  $("#register-form").children().unbind('click')
#   else 
#     $('.loader').show()
#     $('.shadow').css("opacity" , "0.7")
#     $("#register-form").children().bind('click', function(){ return false; });


$(document).ready ->
	if window.jQuery
		Log "ready"
	
	
