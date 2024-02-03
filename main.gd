extends Node2D

var level: int = 1
var playing_bgm_playing: bool = false

var level_information : Array = [
	# 头 翅膀 腿 选择次数 Nice区间
	[5, -0.5, -0.5, 0, 0, 5],
	[5, -0.5, -0.5, 1, 5, 10],
	[-0.5, 5, -0.5, 1, 10, 20],
	[-0.5, -0.5, 5, 2, 15, 30],
	
	[5, 5, -0.5, 3, 25, 40],
	[5, -0.5, 5, 4, 25, 40],
	[-0.5, 5, 5, 4, 30, 45],
]

## 将场景转化到报纸界面
func change_to_new_newspaper() -> void:
	level += 1
	if level == 8:
		back_to_begin()
		return
	if get_node("playing"):
		get_node("playing").queue_free()
	if get_node("ege"):
		get_node("ege").queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "newspaper"
	newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/关卡" + str(level) + ".png")
	add_child(newspaper)

## 场景转化为彩蛋界面
func change_to_ege(limb: String) -> void:
	level += 1
	if level == 8:
		back_to_begin()
		return
	get_node("playing").queue_free()
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "ege"
	newspaper.is_ege = true
	match limb:
		"head":
			$Achievement.get_achievement("ManyHead")
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋1.png")
		"wing":
			$Achievement.get_achievement("ManyWing")
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋2.png")
		"leg":
			$Achievement.get_achievement("ManyLeg")
			newspaper.get_node("TextureRect").texture = load("res://Resource/NewsPaper/彩蛋3.png")
	add_child(newspaper)

func back_to_begin() -> void:
	for child in get_children():
		if not child.is_in_group("Stable"):
			child.queue_free()
	var startMenu = preload("res://MianScenes/start_menu.tscn").instantiate()
	startMenu.name = "StartMenu"
	add_child(startMenu)
	level = 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		back_to_begin()

func _on_bgm_finished() -> void:
	if playing_bgm_playing:
		get_node("/root/Main/Music/bgm").play()
