extends Control
class_name PlayerInfo

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	PlayerInfoGlue.buff_detail_panel = buff_detail_panel
	PlayerInfoGlue.buff_detail_label = buff_detail_label
	
	PlayerInfoGlue.player_money_label = player_money_label
	PlayerInfoGlue.player_work_label = player_work_label
	PlayerInfoGlue.player_emotion_progress = player_emotion_progress
	
	PlayerInfoGlue.buff_box = buff_box
	
	PlayerInfoGlue.initialize_player_base_info(666,6,50)
	# 测试

@export var buff_detail_panel : Panel
@export var buff_detail_label : Label

@export var player_money_label : Label
@export var player_work_label : Label
@export var player_emotion_progress : ProgressBar

@export var buff_box : BuffBox

var mouse_in_emotion : bool = false :
	set(value):
		mouse_in_emotion = value
		PlayerInfoGlue.show_emotion_buff = mouse_in_emotion

func _on_emotion_progress_mouse_entered() -> void:
	mouse_in_emotion = true


func _on_emotion_progress_mouse_exited() -> void:
	mouse_in_emotion = false
