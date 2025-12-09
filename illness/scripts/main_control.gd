extends Control
class_name MainControl


var parent : MainScene
func initialize(parameter : MainScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
