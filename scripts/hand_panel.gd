extends Panel
class_name HandPanel

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	Hand.hand_panel_position = global_position
	print(Hand.hand_panel_position)


func _on_button_button_down() -> void:
	$Card.global_position = Hand.hand_panel_position
