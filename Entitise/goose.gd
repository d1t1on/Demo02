extends Node2D

var unmove: bool = false:
	set = unmove_func
var velocity: Vector2 = Vector2.ZERO
var animated: bool = false
var speed: int = 4
var moveStop: bool = false
var stopAnimation: bool = false

func unmove_func(new_unmove: bool) -> void:
	if new_unmove == true:
		velocity = Vector2.ZERO
	unmove = new_unmove

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

func _input(event: InputEvent) -> void:
	if not unmove:
		if event.is_action("move_right"):
			if event.is_pressed():
				velocity.x = speed
			elif event.is_released():
				velocity.x = 0
		if event.is_action("move_left"):
			if event.is_pressed():
				velocity.x = -speed
			elif event.is_released():
				velocity.x = 0
		if event.is_action("move_down"):
			if event.is_pressed():
				velocity.y = speed
			elif event.is_released():
				velocity.y = 0
		if event.is_action("move_up"):
			if event.is_pressed():
				velocity.y = -speed
			elif event.is_released():
				velocity.y = 0

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
