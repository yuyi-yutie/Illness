extends Panel
class_name ShopCardPanel

var parent : ShopPanel

func initialize(parameter : ShopPanel) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
