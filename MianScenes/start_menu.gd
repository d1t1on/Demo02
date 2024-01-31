extends Control

@onready var fsm: Node = $"../FSM"

## 退出按钮退出游戏
func _on_qiut_button_pressed() -> void:
	get_tree().quit()

## 开始按钮调用状态机加载报纸页面
func _on_start_button_pressed() -> void:
	fsm.start_to_newspaper()
	get_node("/root/Main/Music/start_btn").play()

## 确保主界面音乐循环播放
func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
