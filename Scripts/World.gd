extends Node2D

var turn_one = true

var shake_amount = 1

var row_instance

var blown_up = false

onready var dynamic_row = preload("res://Scenes/DynamicRow.tscn")

var visible_rows = []

	
#func camera_shake(shake_amount = 10):
#	$PlayerNode/Camera2D.set_offset(Vector2( \
#		rand_range(-3.0, 3.0) * shake_amount, \
#		rand_range(-3.0, 3.0) * shake_amount \
#	))

func _ready() -> void:
	for n in 8:
		add_row()
		move_down()
	$"/root/Global".first_run = false

	

func add_row():
	row_instance = dynamic_row.instance()
	add_child(row_instance)
	# add the newly created row to the all-rows array
	visible_rows.append(row_instance)

		
func move_down():
	# move everything down
	for n in visible_rows:
		for p in 11:
			yield(get_tree().create_timer(0.00005), "timeout")
			n.position.y += 6
	add_row()
	if blown_up:
		blown_up = false
#	$RowBoom.play()

func blow_shit_up():
	var blown_up = visible_rows[0]
	blown_up.queue_free()
	blown_up = true
	visible_rows.remove(0)
				
func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel"):
		if !blown_up:
			blow_shit_up()

