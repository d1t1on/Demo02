extends Control

@onready var fsm: Node = $"../FSM"

func _on_qiut_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	fsm.start_to_newspaper()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
