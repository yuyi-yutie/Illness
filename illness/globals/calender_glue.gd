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
	hand_panel.add_child(parameter)
	parameter.initialize(hand_panel)
	hand_card_array.append(parameter)
	refresh_hand_position()

func put_card_outof_hand(parameter : Card) -> void:
	if parameter.parent:
		parameter.parent.remove_child(parameter)
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
			hand_card.position.x = current_count * (hand_panel.x - card_size.x) / hand_card_count
			current_count += 1
