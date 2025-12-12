extends Node

var card_size : Vector2 = Vector2( 150 , 250 )
#大概是不会改卡牌的尺寸的

var deck : Array[Card]
#deck是无序的，只包含了卡组中的所有卡牌
var trash_deck : Array[Card]

var deck_card_control : Control :
	set(value):
		deck_card_control = value
		gap = (deck_card_control.size.x - 3 * card_size.x) / 4
		#在此初始化gap

var in_deck : bool = false :
	set(value):
		current_deck_row_count = ceil(deck.size() / 3.0)
var in_trash_deck : bool = false :
	set(vaule):
		current_deck_row_count = ceil(deck.size() / 3.0)

var current_deck_row_count : int = 0

var gap : float = 35.0 / 4

var row1_x : float = gap
var row2_x : float = gap*2 + 150
var row3_x : float = gap*3 + 150*2

var col1_y : float = gap

func show_deck() -> void:
	deck_card_control.size.y = (current_deck_row_count + 1) * gap + current_deck_row_count * 250 
	var show_array : Array[Card] = id_sort_card(deck)
	var current_count : int = 0
	for col in current_deck_row_count:
		for row in range(0,3):
			if show_array[current_count]:
				show_array[current_count].position#TODO

func id_sort_card(parameter : Array[Card]) -> Array[Card]:
	var result : Array[Card] = []
	#TODO
	return result

#还没写完
