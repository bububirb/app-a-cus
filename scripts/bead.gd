extends Area2D

signal slide

export var index = 0
var value = 0

func _on_Bead_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("slide", index, value)
#		value = 1 - value
#		print(value)
