extends TextEdit


func _on_TextEdit_text_changed():
	
	var line = cursor_get_line()
	var column = cursor_get_column()
#	print(get_word_under_cursor())
#	match text[text.length()-1]:
#		"(":
#			text += "  )"
#
#
#			var word = get_line(line)
#			if word.count("func") > 0:
#				print("is func")
#				text += " -> :\n\t\n\tpass\n"
#
#			cursor_set_column(column+1)
#			cursor_set_line(line)
