extends Control

#onready var preferences = $Menu/PreferencesPanel/Preferences
var game = preload("res://scenes/game.tscn")

func _ready():
	if OS.get_name() == "Windows":
		$Menu/QuitButton.show()

func _on_StartButton_pressed():
	var _err = get_tree().change_scene_to(game)
#	$Menu.hide()
#	$Game.show()

#func _on_ThemeColorOptionButton_item_selected(index):
#	var color_name = preferences.get_node("ThemeColor/ThemeColorOptionButton").get_item_text(index)
#	var color = Color()
#	match color_name:
#		"Default":
#			color = Color.white
#		"Red":
#			color = Color.red
#		"Orange":
#			color = Color.orange
#		"Yellow":
#			color = Color.yellow
#		"Green":
#			color = Color.green
#		"Cyan":
#			color = Color.cyan
#		"Blue":
#			color = Color.blue
#		"Indigo":
#			color = Color.indigo
#		"Violet":
#			color = Color.violet
#	$Panel.modulate = color.lightened(0.8)
#	$Game.get_node("Control/Abacus").modulate = color.lightened(0.6)
#	$Panel.modulate = Color.from_hsv(float(index)/9.5, 0.2, 1.0, 1.0)
#	$Game.get_node("Control/Abacus").modulate = Color.from_hsv(float(index)/9.5, 0.5, 1.0, 1.0)

#func _on_PreferencesButton_pressed():
#	$Menu/PreferencesPanel.show()
#
#func _on_PreferencesBackButton_pressed():
#	$Menu/PreferencesPanel.hide()

func _on_QuitButton_pressed():
	get_tree().quit()
