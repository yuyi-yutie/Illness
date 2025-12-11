extends Panel
class_name Card

@export var name_label : Label
@export var time_label : Label

#region 类别

enum CardType {
	Medical ,
	Activity
}
#该卡为医疗还是活动卡

enum TimeType {
	RealTime ,
	Schedule
}
#该卡即时生效还是日程生效

@export var card_type : CardType
@export var time_type : TimeType
#endregion

@export var _name : String = "卡牌名" :
	set(value):
		_name = value
		name_label.text = value

@export var time : int = -1 :
	set(value):
		time = value
		time_label.text = str(time)

@export var card_detail : String

@export var card_picture : TextureRect

#测试
func initialize(_parameter) -> void:
	_name = _name
	time = time

#region 鼠标检测
func _on_mouse_entered() -> void:
	CardGlue.current_hover_card = self

func _on_mouse_exited() -> void:
	if CardGlue.current_hover_card == self:
		CardGlue.current_hover_card = null
#endregion
