extends Panel
class_name CardDetailPanel

@onready var card_detail_label: Label = $CardDetail/CardDetailLabel
@onready var card_container: Control = $CardContainer
@onready var card_detail: Control = $CardDetail

var parent : MainControl

func initialize(parameter : MainControl) -> void:
	parent = parameter
	CardToDetail.detail_panel = self
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
