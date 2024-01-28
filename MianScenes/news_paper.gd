extends Control

func _enter_tree() -> void:
	if get_node("/root/Main/Music/over").is_playing():
		get_node("/root/Main/Music/over").stop()
	get_node("/root/Main/Music/newspaper").play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				print("从报纸界面跳转到游戏界面")
				get_node("../FSM").newspaper_to_playing()
