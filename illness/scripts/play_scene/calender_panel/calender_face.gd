extends Panel
class_name CalenderPanel

var parent : Calender

func initialize(parameter : Calender) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
