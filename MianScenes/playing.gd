extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var goose: Node2D = $Goose
var reversed: bool = false
var total_mark: float = 0
var mark: Dictionary = {
	"head" : 1,
	"wing" : 2,
	"leg" : 2
}
@onready var select_times:int 
var level: int

func _enter_tree() -> void:
	select_times = get_parent().level_information[level - 1][3]
	if get_parent().level_information[level - 1][0] > 0:
		# head
		$UI/VBoxContainer/HeadNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/HeadNumber/Label.modulate = Color(0,0,0)

	if get_parent().level_information[level - 1][2] > 0:
		# wing
		$UI/VBoxContainer/WingNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/WingNumber/Label.modulate = Color(0,0,0)

	if get_parent().level_information[level - 1][1] > 0:
		# leg
		$UI/VBoxContainer/LegNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/LegNumber/Label.modulate = Color(0,0,0)
		
func into_car(area: Area2D) -> void:
	get_node("/root/Main/Music/car").play()
	$UI/SaleStore.show()
	get_node("Goose").unmove = true
	if $Select/Control/NinePatchRect.times >= 0:
		$UI/SaleStore/confirm/Label.text = "是否出售"
	else:
		$UI/SaleStore/confirm/Label.text = "你真这么做吗"

func end_game() -> void:
	count_mark()
	if total_mark < get_parent().level_information[level - 1][4]:
		print("bruh")
		$UI/SaleStore/level_end/AnimatedSprite2D.play("bruh")
		$UI/SaleStore/level_end/Label.text = "你离良好差" + str(get_parent().level_information[level - 1][4] - total_mark) + "分"
	elif total_mark >= get_parent().level_information[level - 1][4] \
	and total_mark < get_parent().level_information[level - 1][5]:
		print("nice")
		$UI/SaleStore/level_end/AnimatedSprite2D.play("nice")
		$UI/SaleStore/level_end/Label.text = "你离天才还差" + str(get_parent().level_information[level - 1][5] - total_mark) + "分"
	else:
		print("genius")
		$UI/SaleStore/level_end/AnimatedSprite2D.play("genius")
		$UI/SaleStore/level_end/Label.text = str(total_mark) + "分你做到了!"

func count_mark() -> void:
	total_mark = 0
	var count_level = get_parent().level_information[0]
	total_mark += mark["head"] * count_level[0]
	total_mark += mark["wing"] * count_level[1]
	total_mark += mark["leg"] * count_level[2]
	
func into_reverse(area: Area2D) -> void:
	if not reversed:
		get_node("/root/Main/Music/car").play()
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
	get_node("/root/Main/Music/car").play()
	camera_2d.position.x = 1920 * 2
	goose.position = $Select/SelectOrignalPoint.global_position
	goose.unmove = true
	goose.scale *= 1.2
	goose.z_index = 2
	goose.velocity = Vector2.ZERO

func exit_select() -> void:
	if goose == null:
		return
	camera_2d.position.x = 0
	goose.position = $orignalPoint.global_position
	goose.unmove = false
	goose.scale = Vector2(1,1)
	goose.z_index = 0
