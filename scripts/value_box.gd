extends LineEdit

var regex = RegEx.new()
var oldtext = "0"

func _ready():
	regex.compile("^[0-9]*$")

func _on_ValueBox_text_changed(new_text):
	if regex.search(new_text):
		text = new_text
		oldtext = text
	else:
		text = oldtext
	set_cursor_position(text.length())
