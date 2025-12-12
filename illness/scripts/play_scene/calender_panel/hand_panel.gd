extends Panel
class_name HandPanel

var current_hand_count : int

var max_hand_count : int

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	CalenderGlue.hand_panel = self
