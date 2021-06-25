extends Control

var main = load("res://scenes/main.tscn")

var last_value = 0.0
var value = 0.0
var factor = 0.0

var text_entered = true

var number_pad_visible = false

onready var value_box = $Controls/ValueBox
onready var timer = $Controls/Timer

onready var abacus = $Controls/Center/Abacus

onready var plus_button = $Controls/PlusButton
onready var minus_button = $Controls/MinusButton
onready var anim_player = $AnimationPlayer

func _ready():
	randomize()

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		var _err = get_tree().change_scene_to(main)
#		hide()
#		get_parent().get_node("Menu").show()

func _on_Abacus_update(new_value):
	last_value = value
	value = new_value
	factor = 0.0
	timer.start()
#	value_box.text = str(new_value)

func _on_Timer_timeout():
	if factor < 1.0:
		factor += 0.2
	value_box.text = str(int(last_value * (1.0 - factor) + value * factor))
	if factor == 1.0:
		timer.stop()
		if value_box == get_focus_owner():
			value_box.select_all()

func _on_BackButton_pressed():
	if number_pad_visible:
		anim_player.play("number_pad_close")
		number_pad_visible = false
		value_box.text = str(value)
	else:
		var _err = get_tree().change_scene_to(main)
#		hide()
#		get_parent().get_node("Menu").show()

func _on_ValueBox_focus_entered():
	value_box.call_deferred("select_all")
#	pass

func _on_ValueBox_text_entered(new_text):
	abacus.set_value(int(new_text))
	value_box.select_all()

func _on_NumberPad_key_pressed(key):
	if key >= 0 and key <= 9:
		if value_box.text.length() >= 3:
			text_entered = true
		else:
			text_entered = false
		if text_entered:
			value_box.text = ""
		value_box.append_at_cursor(str(key))
#		Input.action_press("KEY_" + str(key))
#		var a = InputEventKey.new()
#		a.scancode = key + 48
#		a.pressed = true
#		value_box.grab_focus()
#		Input.parse_input_event(a)
#		a.pressed = false
#		value_box.grab_focus()
#		Input.parse_input_event(a)
	elif key > 9:
		value_box.emit_signal("text_entered", value_box.text)
		text_entered = true
	elif key < 0:
		value_box.delete_char_at_cursor()

func _on_InputButton_pressed():
	if number_pad_visible == false:
		anim_player.play("number_pad_open")
		number_pad_visible = true
	value_box.text = ""

func _on_CloseNumberPadButton_pressed():
	if number_pad_visible:
		anim_player.play("number_pad_close")
		number_pad_visible = false

func _on_ResetButton_pressed():
	abacus.reset_value()

func _on_PlusButton_pressed():
	abacus.increment()

func _on_MinusButton_pressed():
	abacus.decrement()

func _on_ShuffleButton_pressed():
	abacus.set_value(randi())

#func _on_Game_resized():
#	if rect_size.x > rect_size.y:
#		if columns == 1:
#			columns = 2
#	else:
#		if columns == 2:
#			columns = 1

