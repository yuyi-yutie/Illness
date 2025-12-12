extends Panel
class_name Card

@export var name_label : Label
@export var time_label : Label

var id : int

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

var parent : Control
#这里的parent会有多种可能性，手牌面板，牌堆弃牌堆面板，商店面板

#测试
func initialize(parameter : Control) -> void:
	parent = parameter
	id = DeckGlue.get_id(self)
	_name = _name
	time = time

#region 鼠标检测
func _on_mouse_entered() -> void:
	CardGlue.current_hover_card = self

func _on_mouse_exited() -> void:
	if CardGlue.current_hover_card == self:
		CardGlue.current_hover_card = null
#endregion


#测试
func click() -> void:
	CalenderGlue.put_card_outof_hand(self)
	DeckGlue.add_to_trash_deck(self)
