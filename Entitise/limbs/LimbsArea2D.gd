extends Area2D

var mouse_in_area: bool = false

func _ready() -> void:
	mouse_entered.connect(
		func() -> void:
			mouse_in_area = true
	)
	mouse_exited.connect(
		func() -> void:
			mouse_in_area = false
	)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			print("hhh")
			if event.is_pressed() and mouse_in_area:
				get_parent().modulate = Color(1,0,0)
