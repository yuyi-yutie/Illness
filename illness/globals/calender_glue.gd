extends Node

#管理日历的脚本

var card_size : Vector2 = Vector2(150 , 250)

var medical_schedule_box : ScheduleBox
var activity_schedule_box : ScheduleBox

var ab_medical_schedule_box : ScheduleBox
var ab_activity_schedule_box : ScheduleBox


var hand_panel : Panel

var hand_card_array : Array[Card]
#每次有牌加入手牌，都需要添加到这个数组中

func put_card_into_hand(parameter : Card) -> void:
	if parameter.parent:
		parameter.parent.remove_child(parameter)
		parameter.parent = null
	hand_panel.add_child(parameter)
	parameter.initialize(hand_panel)
	hand_card_array.append(parameter)
	refresh_hand_position()

func put_card_outof_hand(parameter : Card) -> void:
	if parameter.parent:
		parameter.parent.remove_child(parameter)
		parameter.parent = null
	parameter.position += Vector2(1000,1000)
	#测试

func refresh_hand_position() -> void:
	var hand_card_count : int = hand_card_array.size()
	var current_count : int = 0
	if hand_card_count * card_size.x <= hand_panel.size.x:
		for hand_card in hand_card_array:
			hand_card.position.y = 0
			hand_card.position.x = current_count * card_size.x
			current_count += 1
	else:
		for hand_card in hand_card_array:
			hand_card.position.y = 0
			hand_card.position.x = current_count * (hand_panel.size.x-card_size.x) / (hand_card_count-1) 
			current_count += 1

var hover_ready_to_queue : Card: #这是将要放入执行队列的牌，要提示它的时间范围
	set(value):
		hover_ready_to_queue = value
		if hover_ready_to_queue == null:
			schedule_ready_rect_activity.visible = false
			schedule_ready_rect_medical.visible = false
			return
		match hover_ready_to_queue.card_type:
			Card.CardType.Medical:
				if hover_ready_to_queue.time + occupy_time_medical > 7:
					return
				schedule_ready_rect_medical.visible = true
				
				schedule_ready_rect_medical.position.x = (gap + grid_size.x) * occupy_time_medical
				
				schedule_ready_rect_medical.size.x = gap * (hover_ready_to_queue.time - 1) + grid_size.x * hover_ready_to_queue.time 
			Card.CardType.Activity:
				if hover_ready_to_queue.time + occupy_time_activity > 7:
					return
				schedule_ready_rect_activity.visible = true
				
				schedule_ready_rect_activity.position.x = (gap + grid_size.x) * occupy_time_activity
				
				schedule_ready_rect_activity.size.x = gap * (hover_ready_to_queue.time - 1) + grid_size.x * hover_ready_to_queue.time 

#这个时间后面要在卡牌的执行里加上去
var occupy_time_medical : int = 0
var occupy_time_activity : int = 0

var schedule_ready_rect_medical : TextureRect
var schedule_ready_rect_activity : TextureRect

var gap : int = 25
var grid_size : Vector2 = Vector2(100,100)

var card_in_queue_medical : Array[Card] = []
var card_in_queue_activity : Array[Card] = []

var box_in_queue_medical : Array[FillBox] = []
var box_in_queue_activity : Array[FillBox] = []

const FILL_BOX = preload("uid://2vtxtkabw0ds")

func add_card_in_queue(parameter : Card) -> void:
	var fill_box : FillBox = FILL_BOX.instantiate()
	fill_box.occupy_time = parameter.time
	match parameter.card_type:
		Card.CardType.Medical:
			card_in_queue_medical.append(parameter)
			box_in_queue_medical.append(fill_box)
			medical_schedule_box.add_child(fill_box)
			fill_box.position.x = (gap + grid_size.x) * occupy_time_medical 
			fill_box.size.x = parameter.time * grid_size.x + gap * (parameter.time-1) 
			occupy_time_medical += parameter.time
		Card.CardType.Activity:
			card_in_queue_activity.append(parameter)
			box_in_queue_activity.append(fill_box)
			activity_schedule_box.add_child(fill_box)
			fill_box.position.x = (gap + grid_size.x) * occupy_time_activity
			fill_box.size.x = parameter.time * grid_size.x + gap * (parameter.time-1)
			occupy_time_activity += parameter.time

func return_card_to_hand_through_fillbox(parameter : FillBox) -> void:
	var target : Card = null
	var target_index : int = -1
	if parameter in box_in_queue_medical:
		target_index = box_in_queue_medical.find(parameter)
		target = card_in_queue_medical[target_index]
		occupy_time_medical -= target.time
		box_in_queue_medical[target_index].get_parent().remove_child(box_in_queue_medical[target_index])
		box_in_queue_medical[target_index].queue_free()
		box_in_queue_medical.remove_at(target_index)
		card_in_queue_medical.remove_at(target_index)
		put_card_into_hand(target)
		CardGlue.hover_fill_box = false
	if parameter in box_in_queue_activity:
		target_index = box_in_queue_activity.find(parameter)
		target = card_in_queue_activity[target_index]
		occupy_time_activity -= target.time
		box_in_queue_activity[target_index].get_parent().remove_child(box_in_queue_activity[target_index])
		box_in_queue_activity[target_index].queue_free()
		box_in_queue_activity.remove_at(target_index)
		card_in_queue_activity.remove_at(target_index)
		put_card_into_hand(target)
		CardGlue.hover_fill_box = false
	refresh_fill_box()

func get_hover_card_through_fillbox(parameter : FillBox) -> Card:
	if parameter in box_in_queue_medical:
		return card_in_queue_medical[box_in_queue_medical.find(parameter)]
	if parameter in box_in_queue_activity:
		return card_in_queue_activity[box_in_queue_activity.find(parameter)]
	print("报错：队列中无选中FillBox对应卡牌")
	return null

func refresh_fill_box() -> void:
	var current_occupy_time : int = 0
	for child in medical_schedule_box.get_children():
		if child is FillBox:
			child.position.x = (gap + grid_size.x) * current_occupy_time
			current_occupy_time += child.occupy_time
	current_occupy_time = 0
	for child in activity_schedule_box.get_children():
		if child is FillBox:
			child.position.x = (gap + grid_size.x) * current_occupy_time
			current_occupy_time += child.occupy_time


# 把本脚本的所有变量数组变为初始化
func round_refresh() -> void:
	occupy_time_medical = 0
	occupy_time_activity = 0
	card_in_queue_medical.clear()
	card_in_queue_activity.clear()
	for child in box_in_queue_medical:
		child.queue_free()
	box_in_queue_medical.clear()
	for child in box_in_queue_activity:
		child.queue_free()
	box_in_queue_activity.clear()
	SmallCalenderGlue.week += 1
