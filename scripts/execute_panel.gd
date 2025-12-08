extends Panel
class_name ExcutePanel

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	for child in get_children():
		if child is ExecuteCardPanel:
			child.initialize(self)
