extends Node
class_name CardBuffManager

func execute_buff() -> void:
	for child in get_children():
		if child is Buff:
			child.execute()
