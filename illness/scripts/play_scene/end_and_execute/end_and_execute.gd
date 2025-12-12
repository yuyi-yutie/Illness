extends Control
class_name EndAndExecute

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	DeckGlue.deck_card_control = deck_card_control

@export var deck_card_control : Control

var mouse_in_deck : bool = false:
	set(value):
		mouse_in_deck = value
		DeckGlue.in_deck = mouse_in_deck

var mouse_in_trash_deck : bool = false:
	set(value):
		mouse_in_trash_deck = value
		DeckGlue.in_trash_deck = mouse_in_trash_deck

func _on_deck_panel_mouse_entered() -> void:
	mouse_in_deck = true


func _on_deck_panel_mouse_exited() -> void:
	mouse_in_deck = false


func _on_trash_deck_panel_mouse_entered() -> void:
	mouse_in_trash_deck = true


func _on_trash_deck_panel_mouse_exited() -> void:
	mouse_in_trash_deck = false
