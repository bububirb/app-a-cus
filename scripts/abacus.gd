extends Node2D

signal update

onready var beads = $Beads
onready var columns = $Beads/Columns
onready var column_tops = $Beads/ColumnTops

func _ready():
	for child in columns.get_children():
		child.connect("update", self, "_on_update")
	for child in column_tops.get_children():
		child.connect("update", self, "_on_update")

func _on_update():
	emit_signal("update", get_sum())

func get_sum():
	var sum = 0
	for child in columns.get_children():
		sum += child.get_sum()
	for child in column_tops.get_children():
		sum += child.get_sum()
	return sum

func reset_value():
#	Use when necessary:
#	for column in columns.get_children():
#		for i in column.beads.get_child_count() - 1:
#			if column.beads.get_child(i).value == 1:
#				column._slide_beads(i, 1)
	for child in columns.get_children():
		child.slide_beads(0, 1)
	for child in column_tops.get_children():
		child.slide_beads(0, 5)

func set_value(value):
	value = posmod(int(value), 1000)
#	print(value)
	for i in 3:
#		print(posmod(value / pow(10, i), 10))
#		yield(set_column_value(i, posmod(value / pow(10, i), 10)), "completed")
		set_column_value(i, posmod(value / pow(10, i), 10))

func increment():
	var i = 0
#	while yield(increment_column(i), "completed") == false:
	while increment_column(i) == false:
		if i == 2:
			break
		i += 1

func decrement():
	var i = 0
#	while yield(decrement_column(i), "completed") == false:
	while decrement_column(i) == false:
		if i == 2:
			break
		i += 1

func increment_column(index):
#	yield(get_tree(), "idle_frame")
	var sum = get_column_value(index, false)
	var r5 = posmod(sum, 5)
	var r10 = posmod(sum, 10)
	if r5 < 4:
#		yield(columns.get_child(index).slide_beads(r5, 0), "completed")
		columns.get_child(index).slide_beads(r5, 0)
		return true
	if r5 == 4 and r10 < 9:
#		yield(columns.get_child(index).slide_beads(0, 1), "completed")
		columns.get_child(index).slide_beads(0, 1)
#		yield(column_tops.get_child(index).slide_beads(0, 0), "completed")
		column_tops.get_child(index).slide_beads(0, 0)
		return true
	else:
#		yield(columns.get_child(index).slide_beads(0, 1), "completed")
		columns.get_child(index).slide_beads(0, 1)
#		yield(column_tops.get_child(index).slide_beads(0, 5), "completed")
		column_tops.get_child(index).slide_beads(0, 5)
		return false

func decrement_column(index):
#	yield(get_tree(), "idle_frame")
	var sum = get_column_value(index, false)
	var r5 = posmod(sum, 5)
	var r10 = posmod(sum, 10)
	if r5 > 0 and r5 < 5:
#		yield(columns.get_child(index).slide_beads(r5 - 1, 1), "completed")
		columns.get_child(index).slide_beads(r5 - 1, 1)
		return true
	if r5 == 0 and r10 > 4:
#		yield(columns.get_child(index).slide_beads(3, 0), "completed")
		columns.get_child(index).slide_beads(3, 0)
#		yield(column_tops.get_child(index).slide_beads(0, 5), "completed")
		column_tops.get_child(index).slide_beads(0, 5)
		return true
	else:
#		yield(columns.get_child(index).slide_beads(3, 0), "completed")
		columns.get_child(index).slide_beads(3, 0)
#		yield(column_tops.get_child(index).slide_beads(0, 0), "completed")
		column_tops.get_child(index).slide_beads(0, 0)
		return false

func set_column_value(index, new_value):
#	yield(get_tree(), "idle_frame")
	var value = get_column_value(index, false)
	var r5 = posmod(value, 5)
	var new_r5 = posmod(new_value, 5)
	if r5 < new_r5:
		columns.get_child(index).slide_beads(new_r5 - 1, 0)
#		yield(columns.get_child(index).slide_beads(new_r5 - 1, 0), "completed")
	if new_r5 < r5:
		columns.get_child(index).slide_beads(new_r5, 1)
#		yield(columns.get_child(index).slide_beads(new_r5, 1), "completed")
	if new_value > 4 and value < 5:
		column_tops.get_child(index).slide_beads(0, 0)
#		yield(column_tops.get_child(index).slide_beads(0, 0), "completed")
	if new_value < 5 and new_value < value:
		column_tops.get_child(index).slide_beads(0, 5)
#		yield(column_tops.get_child(index).slide_beads(0, 5), "completed")

func get_column_value(index, multiply_power = true):
	var sum = 0
	sum += columns.get_child(index).get_sum(multiply_power)
	sum += column_tops.get_child(index).get_sum(multiply_power)
	return sum
