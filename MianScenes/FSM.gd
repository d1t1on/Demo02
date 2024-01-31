extends Node

## 从开始页面转化到报纸页面
func start_to_newspaper() -> void:
	if $"../StartMenu" != null:
		# 删除开始页面
		$"../StartMenu".queue_free()
	# 实例化报纸页面并添加到Main节点下
	var newspaper = preload("res://MianScenes/news_paper.tscn").instantiate()
	newspaper.name = "newspaper"
	get_parent().add_child(newspaper)

## 从报纸页面转化为游玩界面
func newspaper_to_playing() -> void:
	if get_node("../newspaper") != null:
		# 删除报纸界面
		get_node("../newspaper").queue_free()
	# 实例化游玩界面并同步关卡数
	var playing = preload("res://MianScenes/playing.tscn").instantiate()
	playing.name = "playing"
	playing.level = get_parent().level
	get_parent().add_child(playing)
