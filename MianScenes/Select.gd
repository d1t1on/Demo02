extends Node2D

var current_mouse_global_position: Vector2
@onready var goose: Node2D = $"../Goose"
var select_limb: Node2D
var selected: bool = false
var select_button_pressed: bool = false
var added: bool = false
var add_limb: Node2D
var selectArray: Array = []
var current_state: String = ""
var head: Array = [
	"res://Entitise/limbs/head.tscn"
]
var leg: Array = [
	"res://Entitise/limbs/leg_b.tscn",
	"res://Entitise/limbs/leg_f.tscn",
]
var wing: Array = [
	"res://Entitise/limbs/wing_b.tscn",
	"res://Entitise/limbs/wing_f.tscn"
]

## 随机生成部位
func rand_spawner() -> void:
	var ranNum: int = randi_range(1, 100)
	print(selectArray)
	var notSelectArray: Array = ["head", "wing", "leg"]
	for select in selectArray:
		notSelectArray.erase(select)
	
	var selectTscn: Array = []
	for select in selectArray:
		match select:
			"head":
				selectTscn.append_array(head)
			"wing":
				selectTscn.append_array(wing)
			"leg":
				selectTscn.append_array(leg)
	var notSelectTscn: Array = []
	for notSelect in notSelectArray:
		match notSelect:
			"head":
				notSelectTscn.append_array(head)
			"wing":
				notSelectTscn.append_array(wing)
			"leg":
				notSelectTscn.append_array(leg)
	
	if ranNum < 50 and selectTscn.size() != 0:
		var index: int = randi_range(0, selectTscn.size() - 1)
		print(selectTscn[index])
		add_limb = load(selectTscn[index]).instantiate()
	elif ranNum >= 50 and notSelectTscn.size() != 0:
		var index: int = randi_range(0, notSelectTscn.size() - 1)
		print(notSelectTscn[index])
		add_limb = load(notSelectTscn[index]).instantiate()

func add_limbs() -> void:
	rand_spawner()
	call_deferred("set_limb")
	
func set_limb() -> void:
	current_mouse_global_position = get_global_mouse_position()
	var direction: Vector2 = (current_mouse_global_position - goose.position).normalized()
	
	# 角度后面再细调
	if add_limb != null:
		add_limb.rotation = direction.angle() + PI / 2
		$"..".mark[add_limb.get_limb_type()] += 1
		$"../UI/VBoxContainer".update($"..".mark.values())
		goose.add_child(add_limb)

# 角度与滚动条进度一致
func roll_limb() -> void:
	select_limb.rotation = ($Control/VScrollBar.value - 50) / 50 * PI

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				if current_state == "roll_limb" and not selected:
					for child in goose.get_children():
						if child.mouse_in_area and not selected:
							select_limb = child
							select_limb.modulate = Color(1,0,0)
							$Control/VScrollBar.value = 50
							selected = true
				elif current_state == "add_limb" and not added:
					added = true
					add_limbs()
				else:
					pass

func _on_add_pressed() -> void:
	if get_node("/root/Main").level <= 3 and $Control/NinePatchRect.times == 0:
		return
	
	get_node("/root/Main/Music/add").play()
	for child in $Control/NinePatchRect/limbs.get_children():
		child.add_button_pressed = true
	$Control/NinePatchRect.times -= 1
	added = false
	select_button_pressed = false
	set_default_state_in_limbs()
	current_state = "add_limb"

func _on_roll_pressed() -> void:
	if get_node("/root/Main").level <= 3 and $Control/NinePatchRect.times == 0:
		return
	
	get_node("/root/Main/Music/add").play()
	$Control/NinePatchRect.times -= 1
	selected = false
	select_button_pressed = true
	set_default_state_in_limbs()
	if select_limb != null:
		select_limb.modulate = Color(1,1,1)
	current_state = "roll_limb"

func _on_alright_pressed() -> void:
	get_node("/root/Main/Music/yes").play()
	selected = false
	select_button_pressed = false
	added = false
	set_default_state_in_limbs()
	for gooseChild in goose.get_children():
		gooseChild.modulate = Color(1,1,1)
	for child in $Control/NinePatchRect/limbs.get_children():
		child.add_button_pressed = false
	$"../Reverse/Control/Control".save_temp_player_goose()

func set_default_state_in_limbs() -> void:
	for child in $Control/NinePatchRect/limbs.get_children():
		selectArray.clear()
		match child.name:
			"head":
				child.texture = load("res://Resource/UI/头.png")
			"wing":
				child.texture = load("res://Resource/UI/翅膀.png")
			"leg":
				child.texture = load("res://Resource/UI/腿.png")

func _on_v_scroll_bar_scrolling() -> void:
	get_node("/root/Main/Music/socalView").play()

func _on_v_scroll_bar_value_changed(value: float) -> void:
	if not select_button_pressed:
		$Control/VScrollBar.value = 50
	else:
		roll_limb()
