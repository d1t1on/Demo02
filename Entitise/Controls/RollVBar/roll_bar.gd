extends Control


@onready var button: TextureRect = $button
@export var value: float = 0
@export var maxValue: float = 100

var buttonBottom: float
var buttonTop: float = 0
var mouse_pressed: bool = false

func _ready() -> void:
	buttonBottom = $MarginContainer.size.y - $button.size.y

func _physics_process(delta: float) -> void:
	if mouse_pressed:
		button.position.y = get_local_mouse_position().y
		limit_position()
		count_value()

func limit_position() -> void:
	if button.position.y <= buttonTop:
		button.position.y = buttonTop
	elif button.position.y >= buttonBottom:
		button.position.y = buttonBottom

func on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				mouse_pressed = true
			if event.is_released():
				mouse_pressed = false

func count_value() -> void:
	get_node("/root/Main/Music/socalView").play()
	value = (button.position.y / buttonBottom) * maxValue

func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 4:
			# 向上滚动
			button.position.y -= buttonBottom / 100 * 2
			limit_position()
			count_value()
		elif event.button_index == 5:
			#向下滚动
			button.position.y += buttonBottom / 100 * 2
			limit_position()
			count_value()
