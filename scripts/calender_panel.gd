extends Panel
class_name CalenderPanel

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children() :
		child.initialize(self)
