extends Control

signal key_pressed

func _ready():
	for container in $KeyGrid.get_children():
		for child in container.get_children():
			if child.get_class() != "MarginContainer":
				child.connect("pressed", self, "_on_key_pressed", [child.name])

func _on_key_pressed(key_name: String):
	if key_name.begins_with("Number"):
		emit_signal("key_pressed", int(key_name))
	elif key_name == "Backspace":
		emit_signal("key_pressed", -1)
	else:
		emit_signal("key_pressed", 10)
