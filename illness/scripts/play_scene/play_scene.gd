extends Control
class_name PlayScene

const CALENDER = preload("uid://b76r0tvur6ts8")
const CARD_DETAIL = preload("uid://510js86b2oua")

func _ready() -> void:
	initialize()

func initialize() -> void:
	var calender : Control = CALENDER.instantiate()
	add_child(calender)
	var card_detail : Control = CARD_DETAIL.instantiate()
	add_child(card_detail)
	
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
