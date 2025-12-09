extends Panel
class_name ExecutePanel

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
