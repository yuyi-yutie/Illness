extends Panel
class_name ShopPanel

var parent : Shop

func initialize(parameter : Shop) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
