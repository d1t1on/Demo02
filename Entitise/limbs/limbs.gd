class_name Limb
extends Node2D

@export var mouse_in_area: bool = false
@export var selected: bool = false
@onready var area_2d: Area2D = $Area2D
@export var type: String

func _ready() -> void:
	area_2d.mouse_entered.connect(
		func() -> void:
			mouse_in_area = true
	)
	area_2d.mouse_exited.connect(
		func() -> void:
			mouse_in_area = false
	)

func get_limb_type() -> String:
	if type == "head":
		return "head"
	elif type == "wing":
		return "wing"
	elif type == "leg":
		return "leg"
	else:
		print("出错，不属于任何部位")
		return ""
