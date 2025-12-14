extends Button

const CARD = preload("uid://cqr2tljf25i0j")

func _on_button_down() -> void:
	var new_card : Card = CARD.instantiate()
	new_card.id = DeckGlue.get_id(new_card)
	new_card.time = randi_range(0,7)
	new_card.card_detail = str(randf())
	CalenderGlue.put_card_into_hand(new_card)
	
