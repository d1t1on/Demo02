extends Node2D

var unmove: bool = false
var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	position += velocity
	velocity = velocity.lerp(Vector2.ZERO, delta * 30)

func _input(event: InputEvent) -> void:
	if not unmove:
		if Input.is_action_pressed("move_right"):
			velocity.x = 20
		if Input.is_action_pressed("move_left"):
			velocity.x = -20
		if Input.is_action_pressed("move_down"):
			velocity.y = 20
		if Input.is_action_pressed("move_up"):
			velocity.y = -20
