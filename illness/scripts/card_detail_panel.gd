extends Panel
class_name CardDetailPanel

@onready var card_detail_label: Label = $CardDetail/CardDetailLabel
@onready var card_container: Control = $CardContainer

var parent : MainScene

func initialize(parameter : MainScene) -> void:
	parent = parameter
	CardToDetail.detail_panel = self
