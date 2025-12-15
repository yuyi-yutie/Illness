extends Button

const CARD = preload("uid://cqr2tljf25i0j")

func _on_button_down() -> void:
	var new_card : Card = CARD.instantiate()
	new_card.id = DeckGlue.get_id(new_card)
	new_card.time = randi_range(0,3)
	new_card.card_detail = str(randf())
	CalenderGlue.put_card_into_hand(new_card)
	if new_card.time == 0:
		new_card.time_type = Card.TimeType.RealTime
	else:
		new_card.time_type = Card.TimeType.Schedule
	
	new_card.card_type = randi_range(0,1) as Card.CardType
	
	
	var type_name : String = ""
	match new_card.card_type:
		Card.CardType.Medical:
			type_name = "医疗卡"
		Card.CardType.Activity:
			type_name = "活动卡"
	
	new_card._name = type_name + str(new_card.time)
