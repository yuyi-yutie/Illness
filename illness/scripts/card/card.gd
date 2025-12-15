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
	#id = DeckGlue.get_id(self)
	_name = _name
	time = time

#region 鼠标检测
func _on_mouse_entered() -> void:
	CardGlue.current_hover_card = self
	if parent is HandPanel:
		CalenderGlue.hover_ready_to_queue = self

func _on_mouse_exited() -> void:
	if CardGlue.current_hover_card == self:
		CardGlue.current_hover_card = null
	if parent is HandPanel:
		if CalenderGlue.hover_ready_to_queue == self:
			CalenderGlue.hover_ready_to_queue = null
#endregion


#测试
func click() -> void:
	#这里处理卡牌本身的位置和视觉效果
	if parent is HandPanel:
		if !ShopGlue.in_destroy_type:
			
			#用于检测是否可以放入
			match card_type:
				CardType.Medical:
					if CalenderGlue.occupy_time_medical + time > 7:
						return
				CardType.Activity:
					if CalenderGlue.occupy_time_activity + time > 7:
						return
			
			
			CalenderGlue.put_card_outof_hand(self)
			
			#DeckGlue.add_to_trash_deck(self)
			#后面写执行的时候要把这个改掉，在执行之后再放进弃牌堆
			
			CalenderGlue.hand_card_array.erase(self)
			CalenderGlue.refresh_hand_position()
			put_into_queue()
		else:
			ShopGlue.in_destroy_type = false
			DeckGlue.destroy_card(id)

func put_into_queue() -> void:
	match time_type:
		TimeType.RealTime:
			execute()
		TimeType.Schedule:
			CalenderGlue.add_card_in_queue(self)

func execute() -> void:
	print("执行卡牌" + str(id))
	
	custom_execute()
	
	DeckGlue.add_to_trash_deck(self)

func custom_execute() -> void:
	#这里写卡牌的具体逻辑
	pass
