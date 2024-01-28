extends Node2D

var level: int = 1

var level_information : Array = [
	[5, -0.5, -0.5, 8, 0, 5],
	[5, -0.5, -0.5, 1, 5, 10],
	[-0.5, -0.5, 5, 2, 10, 20],
	[-0.5, -0.5, 5, 2, 15, 30],
]

func change_to_new_newspaper() -> void:
	level += 1
	get_node("playing").queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "newspaper"
	newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/关卡" + str(level) + ".png")
	add_child(newspaper)
