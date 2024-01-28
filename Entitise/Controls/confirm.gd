extends Control

func _on_yes_pressed() -> void:
	get_node("/root/Main/Music/over").play()
	hide()
	$"../level_end".show()
	$"../../..".end_game()
	var your_goose = load("res://MianScenes/mirror/temp_player_goose.tscn").instantiate()
	your_goose.position = - Vector2(200, 200)
	your_goose.scale *= 1.2
	$"../level_end".add_child(your_goose)

func _on_no_pressed() -> void:
	get_parent().hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_node("/root/Main").change_to_new_newspaper()
