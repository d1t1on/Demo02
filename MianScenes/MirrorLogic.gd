extends Control

var GOOSE
var begin_syn_rotation: bool = false

func _process(delta: float) -> void:
	if begin_syn_rotation:
		get_node("left_background/player_goose").rotation = ($VScrollBar.value - 50) / 50 * PI

func mirror_start() -> void:
	GOOSE = load("res://Entitise/temp_resource/temp_goose.tscn")
	generate_left_background()
	call_deferred("generate_player_goose")
	$VScrollBar.value = 50

## 生成左边的背景蒙版
func generate_left_background() -> void:
	var left_background := TextureRect.new()
	left_background.texture = preload("res://MianScenes/mirror/蒙版.png")
	left_background.name = "left_background"
	left_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(left_background)

## 生成右边的背景蒙版
func generate_right_background() -> void:
	var right_background := TextureRect.new()
	right_background.texture = preload("res://MianScenes/mirror/蒙版.png")
	right_background.position = Vector2(size.x / 2, 0)
	right_background.name = "right_background"
	right_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(right_background)

## 生成玩家控制的角色，生成在左边蒙版
func generate_player_goose() -> void:
	var player_goose = GOOSE.instantiate()
	player_goose.name = "player_goose"
	player_goose.position = $"../../ReverseOrignalPoint".position
	get_node("left_background").add_child(player_goose)
	call_deferred("begin_roll")

func begin_roll() -> void:
	begin_syn_rotation = true

## 生成镜像角色，确保在此之前右边蒙版已生成
func generate_mirror_goose() -> void:
	var mirror_goose = GOOSE.instantiate()
	mirror_goose.name = "mirror_goose"
	mirror_goose.scale.x = -1
	get_node("right_background").add_child(mirror_goose)

## 镜像位置
func mirror_position(mirror_goose: Node2D) -> void:
	var player_goose = get_node("left_background/player_goose")
	mirror_goose.global_position = Vector2(2877 * 2 - player_goose.global_position.x ,player_goose.global_position.y)

## 镜像角度
func mirror_rotation(mirror_goose: Node2D) -> void:
	var player_goose = get_node("left_background/player_goose")
	mirror_goose.rotation = -player_goose.rotation

## 复制操作时保存左边部分
func save_left_body() -> void:
	count_mark(get_node("left_background/player_goose"))
	# 将两个背景clip模式变成clip_only，并将镜像角色加入到右侧背景下
	get_node("left_background").clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	generate_right_background()
	generate_mirror_goose()
	get_node("right_background").clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	# 镜像操作
	var mirror_goose = get_node("right_background/mirror_goose")
	mirror_position(mirror_goose)
	mirror_rotation(mirror_goose)
	call_deferred("save_changed_goose")

func save_changed_goose() -> void:
	save_changed_duck_to_file()
	get_node("right_background").free()
	get_node("left_background").free()
	call_deferred("add_new_player_goose")

func save_changed_duck_to_file() -> void:
	Global.change_owner(get_node("right_background"))
	Global.change_owner(get_node("left_background"))
	
	var right_bg_packed := PackedScene.new()
	right_bg_packed.pack(get_node("right_background"))
	ResourceSaver.save(right_bg_packed, "res://MianScenes/mirror/right_bg_packed.tscn")
	
	var left_bg_packed := PackedScene.new()
	left_bg_packed.pack(get_node("left_background"))
	ResourceSaver.save(left_bg_packed, "res://MianScenes/mirror/left_bg_packed.tscn")

func add_new_player_goose() -> void:
	var player_goose := Node2D.new()
	player_goose.name = "Goose"
	player_goose.set_script(load("res://Entitise/goose.gd"))
	player_goose.position = Vector2(1555, 848) - Vector2(860, 880) - Vector2(1000, 0)
	player_goose.position = $TextureRect.size / 2
	
	var r1 = load("res://MianScenes/mirror/right_bg_packed.tscn").instantiate()
	r1.get_child(0).set_script(null)
	player_goose.add_child(r1)
	
	var r2 = load("res://MianScenes/mirror/left_bg_packed.tscn").instantiate()
	r2.get_child(0).set_script(null)
	player_goose.add_child(r2)
	
	begin_syn_rotation = false
	$"../../..".add_child(player_goose)
	$"../../../Camera2D".position.x = 0
	call_deferred("save_temp_player_goose")

func save_temp_player_goose() -> void:
	var temp_player_goose = PackedScene.new()
	Global.change_owner(get_node("../../../Goose"))
	temp_player_goose.pack(get_node("../../../Goose"))
	ResourceSaver.save(temp_player_goose, "res://MianScenes/mirror/temp_player_goose.tscn")

## 但在点击按钮前触发，减过轴向的肢体数量，没过的双倍
func count_mark(player_goose: Node2D) -> void:
	for child in player_goose.get_children():
		if child.name == "body":
			pass
		else:
			if child.get_node("Marker2D") != null:
				if child.get_node("Marker2D").global_position.x > 2877:
					var type = child.get_groups()[0]
					$"../../..".mark[type] -= 1
					$"../../../UI/VBoxContainer".update($"../../..".mark.values())
				else:
					var type = child.get_groups()[0]
					$"../../..".mark[type] += 1
					$"../../../UI/VBoxContainer".update($"../../..".mark.values())
			else:
				print(str(child) + "的Marker2D不存在")
