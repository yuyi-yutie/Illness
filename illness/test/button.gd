extends Button

const CARD = preload("res://scenes/card.tscn")

var hand_panel : HandPanel

func initialize(_parameter : MainScene) -> void:
	pass

func _on_button_down() -> void:
	hand_panel = HandToExecutePanel.hand_panel
	var new_card : Card = CARD.instantiate()
	hand_panel.add_child(new_card)
	new_card._name = "测试"
	new_card.time = 0
	new_card.initialize(hand_panel)
	
