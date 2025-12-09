extends Node

var hover_card : Card = null:
	set(value):
		hover_card = value
		if hover_card !=null:
			detail_panel.card_detail_label.text = hover_card.card_detail
			var card_copy : Card = hover_card.duplicate()
			card_copy.position.x = 0
			detail_panel.card_container.add_child(card_copy)
		if hover_card == null:
			detail_panel.card_detail_label.text = ""
			detail_panel.card_container.get_child(0).queue_free()

var detail_panel : CardDetailPanel
