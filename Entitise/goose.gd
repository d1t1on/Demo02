extends Node2D

var unmove: bool = false
var velocity: Vector2 = Vector2.ZERO
var animated: bool = false
var speed: int = 3
var stopAnimation: bool = false

func _process(delta: float) -> void:
	if not stopAnimation:
		if velocity.length() > 0.2 and not animated:
			start_animation()
		elif velocity.length() < 0.2:
			stop_animation()

		if velocity.x > 0 and scale.x == 1:
			scale.x = -1
		elif velocity.x < 0 and scale.x == -1:
			scale.x = 1
	
	position += velocity
	velocity = velocity.lerp(Vector2.ZERO, delta * 30)

func _input(event: InputEvent) -> void:
	if not unmove:
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed
		if Input.is_action_pressed("move_down"):
			velocity.y = speed
		if Input.is_action_pressed("move_up"):
			velocity.y = -speed

func start_animation() -> void:
	animated = true
	get_node("/root/Main/Music/walk").play()
	get_node("/root/Main/Music/speak").play()
	for child in get_children():
		if child.name == "right_background":
			return
		child.get_node("Sprite2D").hide()
		child.get_node("AnimatedSprite2D").play("move")

func stop_animation() -> void:
	animated = false
	get_node("/root/Main/Music/walk").stop()
	get_node("/root/Main/Music/speak").stop()
	for child in get_children():
		if child.name == "right_background":
			return
		child.get_node("Sprite2D").show()
		child.get_node("AnimatedSprite2D").play("default")
