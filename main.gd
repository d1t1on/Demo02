extends Node2D

var level: int = 1

var level_information : Array = [
	[5, -0.5, -0.5, 0, 0, 5],
	[5, -0.5, -0.5, 1, 5, 10],
	[-0.5, 5, -0.5, 1, 10, 20],
	[-0.5, -0.5, 5, 2, 15, 30],
	
	[5, 5, -0.5, 3, 25, 40],
	[5, -0.5, 5, 4, 25, 40],
	[-0.5, 5, 5, 4, 30, 45],
]

func change_to_new_newspaper() -> void:
	level += 1
	if level == 8:
		var startMenu = preload("res://MianScenes/start_menu.tscn").instantiate()
		startMenu.name = "startMenu"
		return

	if get_node("playing") != null:
		get_node("playing").queue_free()
	if get_node("ege") != null:
		get_node("ege").queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "newspaper"
	newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/关卡" + str(level) + ".png")
	add_child(newspaper)

func change_to_ege(limb: String) -> void:
	level += 1
	get_node("playing").queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "ege"
	newspaper.is_ege = true
	match limb:
		"head":
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋1.png")
		"wing":
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋2.png")
		"leg":
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋3.png")
	add_child(newspaper)
