extends Control
class_name PlayScene

const CALENDER = preload("uid://b76r0tvur6ts8")
const CARD_DETAIL = preload("uid://510js86b2oua")

func _ready() -> void:
	initialize()

func initialize() -> void:
	
	#这里写所有子节点初始化的操作
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
