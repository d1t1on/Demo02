extends Node

func start_to_newspaper() -> void:
	if $"../StartMenu" != null:
		$"../StartMenu".queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "newspaper"
	get_parent().add_child(newspaper)

func newspaper_to_playing() -> void:
	if get_node("../newspaper") != null:
		get_node("../newspaper").queue_free()
	var playing = preload("res://MianScenes/playing.tscn").instantiate()
	playing.name = "playing"
	get_parent().add_child(playing)
