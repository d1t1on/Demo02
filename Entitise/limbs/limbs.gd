extends Node2D

@export var mouse_in_area: bool = false
@export var selected: bool = false
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.mouse_entered.connect(
		func() -> void:
			mouse_in_area = true
	)
	area_2d.mouse_exited.connect(
		func() -> void:
			mouse_in_area = false
	)
