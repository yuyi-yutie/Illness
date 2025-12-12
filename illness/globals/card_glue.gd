extends Node

var card_detail_label : Label
var fake_card_name_label : Label
var fake_card_time_label : Label
var fake_card_picture : TextureRect
var fake_card_panel : Panel

var current_hover_card : Card = null :
	set(value):
		current_hover_card = value
		if current_hover_card != null:
			fake_card_panel.visible = true
			card_detail_label.text = current_hover_card.card_detail
			fake_card_name_label.text = current_hover_card._name
			fake_card_time_label.text = str(current_hover_card.time)
			fake_card_picture.texture = current_hover_card.card_picture.texture
		else:
			fake_card_panel.visible = false
			card_detail_label.text = ""

var card_array : Array[Card]
var current_id : int = -1
#因为开头要+1，所以这里取-1，初始值就为0

func get_id(card : Card) -> int:
	#卡牌将要放入卡组和手牌时（即玩家将永久获得某张卡牌时），赋值id，以后取牌也是从id获取
	current_id += 1
	card_array[current_id] = card
	return current_id

func refresh_card_id_dic() -> void:
	card_array.clear()
	current_id = -1

func get_card(id : int) -> Card:
	return card_array[id]
