extends VBoxContainer

func update(newArray: Array) -> void:
		$HeadNumber/Label.text = "     X " + str(newArray[0])
		$WingNumber/Label.text = "X " + str(newArray[1])
		$LegNumber/Label.text = "        X "+ str(newArray[2])
