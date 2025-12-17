extends Control
class_name EndAndExecute

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	DeckGlue.deck_card_control = deck_card_control
	DeckGlue.deck_card_box = deck_card_box
	DeckGlue.deck_detail_panel = deck_detail_panel
	deck_detail_panel.visible = false

@export var deck_card_control : Control
@export var deck_card_box : VBoxContainer
@export var deck_detail_panel : Panel
@export var execute_label : Label

var mouse_in_deck : bool = false:
	set(value):
		mouse_in_deck = value
		DeckGlue.in_deck = mouse_in_deck

var mouse_in_trash_deck : bool = false:
	set(value):
		mouse_in_trash_deck = value
		DeckGlue.in_trash_deck = mouse_in_trash_deck

func _on_deck_panel_mouse_entered() -> void:
	mouse_in_deck = true
	DeckGlue.show_deck(DeckGlue.deck)


func _on_deck_panel_mouse_exited() -> void:
	mouse_in_deck = false


func _on_trash_deck_panel_mouse_entered() -> void:
	mouse_in_trash_deck = true
	DeckGlue.show_deck(DeckGlue.trash_deck)


func _on_trash_deck_panel_mouse_exited() -> void:
	mouse_in_trash_deck = false


var is_in_detail_panel : bool = false

func _on_deck_detail_panel_mouse_entered() -> void:
	is_in_detail_panel = true


func _on_deck_detail_panel_mouse_exited() -> void:
	is_in_detail_panel = false
	check_if_end_show()

func check_if_end_show() -> void:
	if CardGlue.current_hover_card:
		return
	if mouse_in_deck:
		return
	if mouse_in_trash_deck:
		return
	if is_in_detail_panel:
		return
	DeckGlue.end_show()


func _on_execute_button_mouse_entered() -> void:
	check_if_end_show()
	execute_label.text = "执行按钮悬浮文本"
	deck_detail_panel.visible = true

#鼠标水平向左离开牌堆时，不会触发检查结束，于是有这个补丁
func _on_bd_mouse_entered() -> void:
	check_if_end_show()
	deck_detail_panel.visible = false


func _on_execute_button_mouse_exited() -> void:
	execute_label.text = ""
	check_if_end_show()
	deck_detail_panel.visible = false

# 这是点击执行按钮执行的逻辑，后面要根据执行顺序改
# 将要执行的卡牌在CalenderGlue里，变量是card_in_queue_medical/activity : Array[Card]
# buff列表在PlayerInfoGlue里，变量是current_buff_array : Array[Buff]
# 同时间执行顺序是先医疗再活动，最后buff
func _on_execute_button_button_down() -> void:
	
	var card_in_queue_medical : Array[Card] = CalenderGlue.card_in_queue_medical
	var card_in_queue_activity : Array[Card] = CalenderGlue.card_in_queue_activity
	
	var current_time : int = 0
	
	var medical_time_flag_array : Array[int] = []
	var activity_time_flag_array : Array[int] = []
	
	for medical_card in card_in_queue_medical:
		medical_time_flag_array.append(medical_card.time)
	for activity_card in card_in_queue_activity:
		activity_time_flag_array.append(activity_card.time)
	
	var current_medical_card_flag : int = 0
	var current_activity_card_flag : int = 0
	
	while(current_time <= 7):
		
		var medical_cal_time_sum : int = 0
		for cal_time in medical_time_flag_array:
			medical_cal_time_sum += cal_time
			if medical_cal_time_sum == current_time:
				card_in_queue_medical[current_medical_card_flag].execute()
				current_medical_card_flag += 1
		
		var activity_cal_time_sum : int = 0
		for cal_time in activity_time_flag_array:
			activity_cal_time_sum += cal_time
			if activity_cal_time_sum == current_time:
				card_in_queue_activity[current_activity_card_flag].execute()
				current_activity_card_flag += 1
		
		#---这里写每天执行的buff---
		
		current_time += 1
	
	#---这里写每周执行的buff---
	
	#---这里写每周结束时的固定逻辑（包括病毒增长，商店刷新等）---
	CalenderGlue.round_refresh()
