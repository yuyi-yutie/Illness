extends Node
class_name PlayScene

func _ready() -> void:
	for child in get_children() :
		if child is CalenderPanel :
			child.initialize(self)
