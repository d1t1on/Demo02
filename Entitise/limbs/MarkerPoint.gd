extends Marker2D

func in_mirror() -> void:
	if position.x > 4800:
		print("减一点当前类型数量")
