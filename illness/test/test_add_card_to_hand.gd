extends Button

const CARD = preload("uid://cqr2tljf25i0j")

func _on_button_down() -> void:
	var new_card : Card = CARD.instantiate()
	CalenderGlue.hand_panel
