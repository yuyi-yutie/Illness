extends Node

#管理日历的脚本

var card_size : Vector2 = Vector2(150 , 250)

var medical_schedule_box_position : Vector2
var activity_schedule_box_position : Vector2

var ab_medical_schedule_box_position : Vector2
var ab_activity_schedule_box_position : Vector2



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
