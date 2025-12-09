extends Node
class_name MainScene

func _ready() -> void:
	for child in get_children() :
		if child.has_method("initialize"):
			child.initialize(self)
