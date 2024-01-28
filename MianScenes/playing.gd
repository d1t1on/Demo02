extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var goose: Node2D = $Goose
var reversed: bool = false
var mark: Dictionary = {
	"head" : 1,
	"wing" : 2,
	"leg" : 2
}
	

func into_car(area: Area2D) -> void:
	print("进入结算画面")
	
func into_reverse(area: Area2D) -> void:
	if not reversed:
		save_current_goose()
		reversed = true
		camera_2d.position.x = 1920
		goose.free()
		$Reverse/Control/Control.mirror_start()

func save_current_goose() -> void:
	var goose_file = PackedScene.new()
	Global.change_owner(goose)
	goose_file.pack(goose)
	ResourceSaver.save(goose_file, "res://Entitise/temp_resource/temp_goose.tscn")

func into_select(area: Area2D) -> void:
	if goose == null:
		return
	camera_2d.position.x = 1920 * 2
	goose.position = $Select/SelectOrignalPoint.global_position
	goose.unmove = true
	goose.scale *= 1.5
	goose.z_index = 2

func exit_select() -> void:
	if goose == null:
		return
	camera_2d.position.x = 0
	goose.position = $orignalPoint.global_position
	goose.unmove = false
	goose.scale = Vector2(1,1)
	goose.z_index = 0
	
