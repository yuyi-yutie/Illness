extends Node

#管理牌堆的脚本

var card_size : Vector2 = Vector2( 150 , 250 )
#大概是不会改卡牌的尺寸的

var whole_deck : Array[Card]
#whole_deck是有序的，按id从前往后排

var deck : Array[Card]
#deck是有序的，包含了抽牌堆中的所有卡牌，是按抽牌顺序排的

var trash_deck : Array[Card]
#trash_deck是有序的，包含了弃牌堆中的所有卡牌，是按弃牌顺序排的

var deck_card_control : Control :
	set(value):
		deck_card_control = value
		gap = (deck_card_control.size.x - 3 * card_size.x) / 4
		#在此初始化gap
var deck_card_box : VBoxContainer
var deck_detail_panel : Panel

var in_deck : bool = false :
	set(value):
		current_deck_row_count = ceil(deck.size() / 3.0)
var in_trash_deck : bool = false :
	set(vaule):
		current_deck_row_count = ceil(trash_deck.size() / 3.0)

var current_deck_row_count : int = 0

var gap : float

#region 牌堆与弃牌堆展示的函数部分

func show_deck(target_deck : Array[Card]) -> void:
	deck_detail_panel.visible = true
	deck_card_box.custom_minimum_size.y = (current_deck_row_count + 1) * gap + current_deck_row_count * 250 
	#初始化要展示的面板y的大小
	
	var show_array : Array[Card] = id_sort_card(target_deck)
	var show_size : int = target_deck.size()
	for current_count in range(show_size):
		var row : int = floori(current_count / 3)
		var col : int = current_count % 3
		if show_array[current_count].parent:
			show_array[current_count].parent.remove_child(show_array[current_count])
			show_array[current_count].parent = null
		deck_card_control.add_child(show_array[current_count])
		show_array[current_count].initialize(deck_card_control)
		show_array[current_count].position.y = gap*(row+1)+ + card_size.y*row
		show_array[current_count].position.x = gap*(col+1) + card_size.x*col
	
	'''
	var current_count : int = 0
	while(current_count != show_size-1):
		for col in range(current_deck_row_count):
			var row = current_count % 3
			if show_array[current_count].parent:
				show_array[current_count].parent.remove_child(show_array[current_count])
				show_array[current_count].parent = null
			deck_card_control.add_child(show_array[current_count])
			show_array[current_count].initialize(deck_card_control)
			show_array[current_count].position.x = gap*(row+1) + card_size.x*row
			show_array[current_count].position.y = gap*(col+1) + card_size.y*col
			current_count += 1
	'''

func id_sort_card(target_deck : Array[Card]) -> Array[Card]:
	var result : Array[Card] = []
	for current_count in whole_deck.size():
		for card in target_deck:
			if card.id == current_count:
				result.append(card)
	return result
#工具函数，用于按id排序牌堆，主牌堆和弃牌堆都行

func end_show() -> void:
	deck_detail_panel.visible = false
	deck_card_box.custom_minimum_size.y = 0
	deck_card_box.size.y = 0
	for deck_card in deck_card_control.get_children():
		if deck_card is Card:
			if deck_card.parent:
				deck_card.parent.remove_child(deck_card)
				deck_card.parent = null
			deck_card.position += Vector2(1000,1000)

#endregion

var current_new_card_id : int = -1
#因为开头要+1，所以这里取-1，初始值就为0

func get_id(parameter : Card) -> int:
	#卡牌将要放入卡组和手牌时（即玩家将永久获得某张卡牌时），赋值id，以后取牌也是从id获取
	current_new_card_id += 1
	whole_deck.append(parameter)
	return current_new_card_id

func get_card(id : int) -> Card:
	return whole_deck[id]

func destroy_card(id : int) -> void:
	current_new_card_id -= 1
	whole_deck.remove_at(id)

func add_to_trash_deck(parameter : Card) -> void:
	if parameter.parent:
		parameter.parent.remove_child(parameter)
		parameter.parent = null
	trash_deck.append(parameter)

func draw_card_from_deck(count : int = 0) -> void:
	if deck.size() == 0:
		refresh_deck()
	if deck.size() == 0:
		print("测试：牌堆中没牌了")
		#这里要补东西
		return
	var target_card : Card = deck[count]
	deck.erase(target_card)
	CalenderGlue.put_card_into_hand(target_card)

func refresh_deck() -> void:
	var deck_size = trash_deck.size()
	for i in deck_size:
		var random_count = randi_range(0,trash_deck.size())
		deck.append(trash_deck[random_count-1])
		trash_deck.remove_at(random_count-1)
	trash_deck.clear()
