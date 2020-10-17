extends TextEdit

func _ready():
	add_color_region("'","'",Color.yellow)
	add_color_region('"','"',Color.pink)
	send_error("Testing error message, IGNORE")
	send_warning("Just Read me and go away!!!")
func send_message(msg:String):
	text += "%s \n" % msg
	pass

func send_error(msg:String):
	text += '" %s "\n' % msg
	pass

func send_warning(msg:String):
	text += "' %s '\n" % msg
	pass
