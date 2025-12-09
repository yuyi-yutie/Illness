extends Button

const CARD = preload("res://scenes/card.tscn")

var hand_panel : HandPanel

func initialize(_parameter : MainControl) -> void:
	pass

func _on_button_down() -> void:
	hand_panel = HandToExecutePanel.hand_panel
	var new_card : Card = CARD.instantiate()
	hand_panel.add_child(new_card)
	new_card.time = randi_range(0,7)
	new_card._name = "测试" + str(new_card.time)
	new_card.card_detail = "测试" + str(new_card.time) + str(new_card.time) 
	new_card.type = randi_range(0,1)
	new_card.initialize(hand_panel)
	
