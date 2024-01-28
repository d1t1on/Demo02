extends NinePatchRect

@export var times:int = 9:
	set = changeTimes

func changeTimes(newTimes: int) -> void:
	times = newTimes
	$LastTimes.text = "剩余操作次数：" + str(times)

func _ready() -> void:
	times = get_node("/root/Main/").level_information[0][3]
	$LastTimes.text = "剩余操作次数：" + str(times)

func _on_add_mouse_entered() -> void:
	$AddTips.text = "从左侧部件中选择其二\n并增加至随机处"
	$AddTips.show()

func _on_add_mouse_exited() -> void:
	$AddTips.hide()
	
func _on_roll_mouse_entered() -> void:
	$AddTips.text = "点击部位进行旋转"
	$AddTips.show()

func _on_roll_mouse_exited() -> void:
	$AddTips.hide()
