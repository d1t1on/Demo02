extends Node2D

var current_mouse_global_position: Vector2
@onready var goose: Node2D = $"../Goose"
var select_limb: Node2D
var selected: bool = false
var added: bool = false
var add_limb: Node2D
var selectArray: Array = []
var current_state: String = ""
var limbs: Array = [
	"res://Entitise/limbs/body.tscn",
	"res://Entitise/limbs/head.tscn",
	"res://Entitise/limbs/leg_b.tscn",
	"res://Entitise/limbs/leg_f.tscn",
	"res://Entitise/limbs/wing_b.tscn",
	"res://Entitise/limbs/wing_f.tscn"
]

func rand_spawner() -> void:
	var ranNum: int = randi_range(1, 100)
	var unnecessryArray: Array = []
	var necessryArray: Array = []
	for select in selectArray:
		for eLimb in limbs:
			if select in eLimb:
				necessryArray.append(eLimb)
			else:
				unnecessryArray.append(eLimb)
	if ranNum < 50:
		if necessryArray.size() == 0:
			return
		add_limb = load(necessryArray[randi_range(0, necessryArray.size() - 1)]).instantiate()
	else:
		if unnecessryArray.size() == 0:
			return
		add_limb = load(unnecessryArray[randi_range(0, unnecessryArray.size() - 1)]).instantiate()

func add_limbs() -> void:
	rand_spawner()
	current_mouse_global_position = get_global_mouse_position()
	var direction: Vector2 = (current_mouse_global_position - goose.position).normalized()
	
	# 角度后面再细调
	if add_limb != null:
		add_limb.rotation = direction.angle() + PI / 2
		$"..".mark[add_limb.get_groups()[0]] += 1
		$"../UI/VBoxContainer".update($"..".mark.values())
		goose.add_child(add_limb)

func _process(delta: float) -> void:
	if selected:
		roll_limb()

func roll_limb() -> void:
	select_limb.rotation = ($Control/VScrollBar.value - 50) / 50 * PI

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				if current_state == "roll_limb" and not selected:
					for child in goose.get_children():
						if child.mouse_in_area:
							select_limb = child
							child.modulate = Color(1,0,0)
							$Control/VScrollBar.value = 50
							selected = true
				elif current_state == "add_limb" and not added:
					added = true
					add_limbs()
				else:
					pass

func _on_add_pressed() -> void:
	$Control/NinePatchRect.times -= 1
	added = false
	current_state = "add_limb"

func _on_roll_pressed() -> void:
	$Control/NinePatchRect.times -= 1
	selected = false
	if select_limb != null:
		select_limb.modulate = Color(1,1,1)
	current_state = "roll_limb"

func _on_alright_pressed() -> void:
	selected = false
	added = false
	for gooseChild in goose.get_children():
		select_limb.modulate = Color(1,1,1)
