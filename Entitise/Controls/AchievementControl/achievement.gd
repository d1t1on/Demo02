extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var texture_rect: TextureRect = $HBoxContainer/MarginContainer/TextureRect
@onready var rich_text_label: RichTextLabel = $HBoxContainer/RichTextLabel

func get_achievement(achievement: String) -> void:
	trans_text(achievement)
	trans_texture(achievement)
	show_achievement()

func trans_text(textName: String) -> void:
	match textName:
		"ManyHead":
			rich_text_label.text = "\n已获得彩蛋\n多头症"
		"ManyWing":
			rich_text_label.text = "\n已获得彩蛋\n大鹅返祖症"
		"ManyLeg":
			rich_text_label.text = "\n已获得彩蛋\n多脚病"

func trans_texture(texureName: String) -> void:
	match texureName:
		"ManyHead":
			texture_rect.texture = load("res://Resource/UI/头.png")
		"ManyWing":
			texture_rect.texture = load("res://Resource/UI/翅膀.png")
		"ManyLeg":
			texture_rect.texture = load("res://Resource/UI/腿.png")

func show_achievement() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(h_box_container, "position", Vector2(0, 0), 2)
	tween.tween_property(h_box_container, "position", Vector2(0, 0), 2)
	tween.tween_property(h_box_container, "position", Vector2(0, -87), 2)
	
