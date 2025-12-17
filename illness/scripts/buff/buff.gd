extends TextureRect
class_name Buff

@export var buff_detail : String

enum TimeType {
	EveryDay ,
	EveryWeek ,
	EveryMonth ,
	EveryYear
}

enum LifeType {
	NextDay ,
	NextWeek ,
	NextMonth ,
	# 可以保证没有下一年
	ThisWeek ,
	ThisMonth ,
	ThisYear ,
	Forever
}

@export var time_type : TimeType

var parent : Control
# buff的父级可以是玩家或者是病毒

func initialize(parameter : Control) -> void:
	parent = parameter

var mouse_in : bool = false

func _on_mouse_entered() -> void:
	PlayerInfoGlue.current_hover_buff = self

func _on_mouse_exited() -> void:
	if PlayerInfoGlue.current_hover_buff == self:
		PlayerInfoGlue.current_hover_buff = null

func execute() -> void:
	pass
