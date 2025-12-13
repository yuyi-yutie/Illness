extends Control
class_name EndAndExecute

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	DeckGlue.deck_card_control = deck_card_control
	DeckGlue.deck_card_box = deck_card_box
	DeckGlue.deck_detail_panel = deck_detail_panel

@export var deck_card_control : Control
@export var deck_card_box : VBoxContainer
@export var deck_detail_panel : Panel

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
	DeckGlue.show_deck(DeckGlue.deck)


func _on_deck_panel_mouse_exited() -> void:
	mouse_in_deck = false


func _on_trash_deck_panel_mouse_entered() -> void:
	mouse_in_trash_deck = true
	DeckGlue.show_deck(DeckGlue.trash_deck)


func _on_trash_deck_panel_mouse_exited() -> void:
	mouse_in_trash_deck = false


var is_in_detail_panel : bool = false

func _on_deck_detail_panel_mouse_entered() -> void:
	is_in_detail_panel = true


func _on_deck_detail_panel_mouse_exited() -> void:
	is_in_detail_panel = false
	check_if_end_show()

func check_if_end_show() -> void:
	if CardGlue.current_hover_card:
		return
	if mouse_in_deck:
		return
	if mouse_in_trash_deck:
		return
	if is_in_detail_panel:
		return
	DeckGlue.end_show()


func _on_execute_button_mouse_entered() -> void:
	check_if_end_show()
	deck_detail_panel.visible = true

#鼠标水平向左离开牌堆时，不会触发检查结束，于是有这个补丁
func _on_bd_mouse_entered() -> void:
	check_if_end_show()
