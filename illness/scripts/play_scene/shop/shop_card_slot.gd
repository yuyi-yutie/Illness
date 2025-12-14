extends Control
class_name ShopCardSlot

var parent : ShopCardPanel

func initialize(parameter : ShopCardPanel) -> void:
	parent = parameter
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)

var card_in_slot : Card

var mouse_in : bool = false

func _on_mouse_entered() -> void:
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false

func _input(event: InputEvent) -> void:
	if !mouse_in:
		return
	if !card_in_slot:
		return
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			if card_in_slot.parent:
				card_in_slot.parent.remove_child(card_in_slot)
				card_in_slot.parent = null
			CalenderGlue.put_card_into_hand(card_in_slot)
			card_in_slot.id = DeckGlue.get_id(card_in_slot)
			card_in_slot = null
