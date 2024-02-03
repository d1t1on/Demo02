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

## 关卡初始化，将需要的对应部位变为红色
func _ready() -> void:
	$UI/ShowLevel.text = "Level：" + str(get_parent().level)
	select_times = get_parent().level_information[level - 1][3]
	if get_parent().level_information[level - 1][0] > 0:
		# 头部
		$UI/VBoxContainer/HeadNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/HeadNumber/Label.modulate = Color(0,0,0)

	if get_parent().level_information[level - 1][1] > 0:
		# 翅膀
		$UI/VBoxContainer/WingNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/WingNumber/Label.modulate = Color(0,0,0)

	if get_parent().level_information[level - 1][2] > 0:
		# 腿部
		$UI/VBoxContainer/LegNumber/Label.modulate = Color(1,0,0)
	else:
		$UI/VBoxContainer/LegNumber/Label.modulate = Color(0,0,0)
		
	$Reverse/Control/Control.save_temp_player_goose()

## 进入车间销售界面
func into_car(area: Area2D) -> void:
	# 播放音乐显示界面
	get_node("/root/Main/Music/car").play()
	$UI/SaleStore.show()
	# 让玩家移动停止
	get_node("Goose").unmove = true
	# 根据剩余选择次数显示文本
	if $Select/Control/NinePatchRect.times >= 0:
		$UI/SaleStore/confirm/Label.text = "是否出售"
	else:
		$UI/SaleStore/confirm/Label.text = "这只鹅严重变异\n你真这么做吗"

func end_game() -> void:
	# 计算得分
	count_mark()
	print(total_mark)
	# 对得分进行评估
	if total_mark < get_parent().level_information[level - 1][4]:
		$UI/SaleStore/level_end/AnimatedSprite2D.play("bruh")
		get_parent().get_node("Music/bruh").play()
		#$UI/SaleStore/level_end/Label.text = str(total_mark) + "分"
		$UI/SaleStore/level_end/Label.text = "你离等级Nice差" + str(get_parent().level_information[level - 1][4] - total_mark) + "分"
	elif total_mark >= get_parent().level_information[level - 1][4] \
	and total_mark < get_parent().level_information[level - 1][5]:
		$UI/SaleStore/level_end/AnimatedSprite2D.play("nice")
		get_parent().get_node("Music/nice").play()
		#$UI/SaleStore/level_end/Label.text = str(total_mark) + "分"
		$UI/SaleStore/level_end/Label.text = "你离等级Gnius还差" + str(get_parent().level_information[level - 1][5] - total_mark) + "分"
	else:
		$UI/SaleStore/level_end/AnimatedSprite2D.play("genius")
		get_parent().get_node("Music/genius").play()
		#$UI/SaleStore/level_end/Label.text = str(total_mark) + "分"
		$UI/SaleStore/level_end/Label.text = "你做到了!"

func count_mark() -> void:
	total_mark = 0
	# 获取当前层数的数组
	var count_level = get_parent().level_information[level - 1]
	# 计算得分
	total_mark += mark["head"] * count_level[0]
	total_mark += mark["wing"] * count_level[1]
	total_mark += mark["leg"] * count_level[2]

## 进入镜像转化车间
func into_reverse(area: Area2D) -> void:
	if not reversed:
		# 播放音乐，保存当前角色数据，标记已进入镜像车间
		get_node("/root/Main/Music/car").play()
		save_current_goose()
		reversed = true
		# 转移摄像头至车间界面，删除原界面角色
		camera_2d.position.x = 3840
		goose.free()
		# 通知对应部件进行初始化
		$Reverse/Control/Control.mirror_start()

## 将当前角色进行数据化本地保存
func save_current_goose() -> void:
	var goose_file = PackedScene.new()
	Global.change_owner(goose)
	goose_file.pack(goose)
	var error = ResourceSaver.save(goose_file, "user://temp_goose.tscn")
	print(error)

## 进入选择车间
func into_select(area: Area2D) -> void:
	if goose == null:
		return
	# 转移摄像头位置，调整角色位置和大小，固定角色
	get_node("/root/Main/Music/car").play()
	camera_2d.position.x = 7680
	goose.position = $Select/SelectOrignalPoint.global_position
	goose.unmove = true
	goose.scale *= 1.2
	goose.z_index = 2
	goose.velocity = Vector2.ZERO
	$Select.can_roll = true

## 退出选择车间
func exit_select() -> void:
	if goose == null:
		return
	camera_2d.position.x = 0
	goose.position = $orignalPoint.global_position
	goose.unmove = false
	goose.scale = Vector2(1,1)
	goose.z_index = 0
