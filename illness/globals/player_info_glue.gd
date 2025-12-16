extends Node

var buff_detail_label : Label
var buff_detail_panel : Panel

var current_hover_buff : Buff = null:
	set(value):
		current_hover_buff = value
		if current_hover_buff == null:
			stop_show_detail()
		else:
			show_detail(current_hover_buff.buff_detail)

var show_emotion_buff : bool = false:
	set(value):
		show_emotion_buff = value
		if show_emotion_buff:
			show_detail(emotion_detail)
		else:
			stop_show_detail()

var emotion_detail : String = "这里是心情详情页"
# 测试

func stop_show_detail() -> void:
	buff_detail_label.text = ""
	buff_detail_panel.visible = false

func show_detail(detail_text : String) -> void:
	buff_detail_label.text = detail_text
	buff_detail_panel.visible = true

var player_money : int = 0 :
	set(value):
		player_money = value
		player_money_label.text = str(player_money)
var player_work : int = 0 :
	set(value):
		player_work = value
		player_work_label.text = str(player_work)
var player_emotion : int = 0 :
	set(value):
		player_emotion = value
		player_emotion_progress.value = player_emotion

var player_money_label : Label
var player_work_label : Label
var player_emotion_progress : ProgressBar

func initialize_player_base_info(money : int , work : int , emotion : int) -> void:
	player_money = money
	player_work = work
	player_emotion = emotion

var current_buff_array : Array[Buff] = []

func add_buff(target : Buff) -> void:
	current_buff_array.append(target)
	if target.parent:
		target.parent.remove_child(target)
		target.parent = null
	buff_box.add_child(target)
	target.initialize(buff_box)
	refresh_buff_box()


var buff_box : BuffBox

var buff_size : Vector2 = Vector2(60,60)
# 测试：这里是buff的大小

# 要出现横向滚动条，就需要增加buff_box的custom_minimum_size.x
func refresh_buff_box() -> void:
	buff_box.custom_minimum_size.x = current_buff_array.size() * buff_size.x
	for buff_index in range(current_buff_array.size()):
		current_buff_array[buff_index].position.x = buff_index * buff_size.x
