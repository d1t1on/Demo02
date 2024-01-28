extends Node2D

var unmove: bool = false

func _input(event: InputEvent) -> void:
	if not unmove:
		if Input.is_action_pressed("move_right"):
			position.x += 10
		if Input.is_action_pressed("move_left"):
			position.x -= 10
		if Input.is_action_pressed("move_down"):
			position.y += 10
		if Input.is_action_pressed("move_up"):
			position.y -= 10
