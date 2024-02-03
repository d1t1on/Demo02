extends Control

func _on_yes_pressed() -> void:
	#get_node("/root/Main/Music/over").play()
	hide()
	$"../level_end".show()
	$"../../..".end_game()
	var your_goose = load("user://temp_player_goose.tscn").instantiate()
	your_goose.set_script(null)
	if $"../../..".reversed:
		your_goose.get_node("right_background/mirror_goose").set_script(null)
		your_goose.get_node("left_background/player_goose").set_script(null)
	if $"../../..".reversed:
		your_goose.position = - Vector2(200, 200)
	else:
		your_goose.position = Vector2(1920 / 2, 1080 / 2) + Vector2(-100, -100)
	your_goose.scale *= 1.2
	
	$"../level_end".add_child(your_goose)
	if get_node("/root/Main/Music/bgm").playing:
		get_node("/root/Main/Music/bgm").stop()
		get_node("/root/Main/").playing_bgm_playing = false

func _on_no_pressed() -> void:
	get_parent().hide()
	$"../../../Goose".unmove = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed() and $"../level_end".visible:
				change_to_next_level()

func change_to_next_level() -> void:
	if get_node("/root/Main/Music/bruh").playing:
		get_node("/root/Main/Music/bruh").stop()
	if get_node("/root/Main/Music/nice").playing:
		get_node("/root/Main/Music/nice").stop()
	if get_node("/root/Main/Music/genius").playing:
		get_node("/root/Main/Music/genius").stop()
	
	if $"../../../Select/Control/NinePatchRect".times < 0:
		var max_number_limb: String = "head"
		for child in $"../../..".mark.keys():
			if $"../../..".mark[max_number_limb] < $"../../..".mark[child]:
				max_number_limb = child
		get_node("/root/Main").change_to_ege(max_number_limb)
	else:
		get_node("/root/Main").change_to_new_newspaper()
