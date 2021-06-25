extends Node2D

signal update

onready var tween = $Tween
onready var beads = $Beads
export var power = 1
var size = 64.0
var time = 0.075

func _ready():
	for child in beads.get_children():
		child.connect("slide", self, "slide_beads")

func slide_beads(index, value):
#	yield(get_tree(), "idle_frame")
	if value == 0:
		for i in index + 1:
			var bead = beads.get_child(i)
			if bead.value == 0:
				tween.interpolate_property(bead, "position:y", bead.position.y, bead.position.y - size, time, 4, 0)
				tween.start()
#				bead.position.y -= 64
				bead.value = 1
#		yield(tween, "tween_all_completed")
	if value == 1:
		for i in 4 - index:
			var bead = beads.get_child(3 - i)
			if bead.value == 1:
				tween.interpolate_property(bead, "position:y", bead.position.y, bead.position.y + size, time, 4, 0)
				tween.start()
#				bead.position.y += 64
				bead.value = 0
#		yield(tween, "tween_all_completed")
	emit_signal("update")

func get_sum(multiply_power = true):
	var sum = 0
	for child in beads.get_children():
		sum += child.value
	if multiply_power:
		return sum * pow(10, power - 1)
	else:
		return sum

func _on_Tween_tween_all_completed():
	$ClackSound.play()
