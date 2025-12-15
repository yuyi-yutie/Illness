extends TextureRect
class_name FillBox

var mouse_in : bool = false

var occupy_time : int = 0

func _on_mouse_entered() -> void:
	mouse_in = true
	CardGlue.hover_fill_box = true
	CardGlue.current_hover_card = CalenderGlue.get_hover_card_through_fillbox(self)

func _on_mouse_exited() -> void:
	mouse_in = false
	CardGlue.hover_fill_box = false
	if CardGlue.current_hover_card == CalenderGlue.get_hover_card_through_fillbox(self): 
		CardGlue.current_hover_card = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			if mouse_in:
				CalenderGlue.return_card_to_hand_through_fillbox(self)
