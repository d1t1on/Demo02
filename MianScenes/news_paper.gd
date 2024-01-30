extends Control

var is_ege: bool = false

func _enter_tree() -> void:
	if get_node("/root/Main/Music/over").is_playing():
		get_node("/root/Main/Music/over").stop()
	get_node("/root/Main/Music/newspaper").play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				if is_ege:
					get_parent().change_to_new_newspaper()
				else:
					get_node("../FSM").newspaper_to_playing()
