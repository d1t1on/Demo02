extends Control

func _on_yes_pressed() -> void:
	hide()
	$"../level_end".show()
	$"../../..".end_game()
	var your_goose = load("res://MianScenes/mirror/temp_player_goose.tscn").instantiate()
	your_goose.position = $"../level_end/Marker2D".position
	your_goose.scale *= 3
	$"../level_end".add_child(your_goose)
	

func _on_no_pressed() -> void:
	get_parent().hide()
