extends TextureRect

var add_button_pressed: bool = false

func _ready() -> void:
	gui_input.connect(click)
	
func click(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed() and add_button_pressed:
				$"../../../..".selectArray.append(name)
				match name:
					"head":
						texture = load("res://Resource/UI/头 已选.png")
					"wing":
						texture = load("res://Resource/UI/翅膀 已选.png")
					"leg":
						texture = load("res://Resource/UI/腿 已选.png")
