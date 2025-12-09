extends Panel
class_name HandPanel

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	HandToExecutePanel.hand_panel = self
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)

func arrange_cards() -> void:
	var self_size : Vector2 = size
	var card_size : Vector2 = HandToExecutePanel.card_size
	var card_count : int = get_child_count()
	if card_size.x * card_count <= self_size.x:
		for i in range(card_count):
			if get_child(i) is Card:
				get_child(i).position.x = card_size.x * i
	else:
		for i in range(card_count):
			if get_child(i) is Card:
				get_child(i).position.x = i * (self_size.x - card_size.x) / (card_count - 1)
