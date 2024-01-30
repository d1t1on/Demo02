extends Control

func _on_yes_pressed() -> void:
	get_node("/root/Main/Music/over").play()
	hide()
	$"../level_end".show()
	$"../../..".end_game()
	var your_goose = load("user://temp_player_goose.tscn").instantiate()
	your_goose.position = - Vector2(200, 200)
	your_goose.scale *= 1.2
	$"../level_end".add_child(your_goose)

func _on_no_pressed() -> void:
	get_parent().hide()
	$"../../../Goose".unmove = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed() and $"../level_end".visible:
				change_to_next_level()

func change_to_next_level() -> void:
	if $"../../../Select/Control/NinePatchRect".times < 0:
		var max_number_limb: String = "head"
		for child in $"../../..".mark.keys():
			if $"../../..".mark[max_number_limb] < $"../../..".mark[child]:
				max_number_limb = child
		print(max_number_limb)
		get_node("/root/Main").change_to_ege(max_number_limb)
	else:
		get_node("/root/Main").change_to_new_newspaper()
