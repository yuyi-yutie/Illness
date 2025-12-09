extends Panel
class_name CalenderPanel

var parent : MainControl

func initialize(parameter : MainControl) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
