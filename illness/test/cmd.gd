extends Panel
class_name cmd

@export var cmd_text : RichTextLabel
@export var cmd_edit : LineEdit

const CARD = preload("uid://cqr2tljf25i0j")
const BUFF = preload("uid://uimtbx032j36")

var is_open : bool = true :
	set(value):
		is_open = value
		self.visible = is_open

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("CallCMD"):
			is_open = !is_open
		if event.is_action_pressed("CMDEnter"):
			
			var flag : bool = false
			#用于返回命令是否有效
			
			cmd_text.add_text("> " + cmd_edit.text + "\n")
			
			if cmd_edit.text == "-h":
				
				flag = true
				
				cmd_text.add_text(">> 按下~键以关闭/打开控制台" + "\n")
				cmd_text.add_text(">> 目前支持以下命令:" + "\n")
				cmd_text.add_text("      add_week  ->  周数+1" + "\n")
				cmd_text.add_text("      draw_card  ->  从牌堆中抽一张牌" + "\n")
				cmd_text.add_text("      add_card  ->  创造一张空白牌放入手牌" + "\n")
				cmd_text.add_text("      add_buff  -> 创造一个空buff" + "\n")
			
			# 加一周
			if cmd_edit.text == "add_week":
				
				flag = true
				
				SmallCalenderGlue.week += 1
				cmd_text.add_text(">> 周数+1" + "\n")
			
			# 从牌堆中抽一张牌
			if cmd_edit.text == "draw_card":
				
				flag = true
				
				DeckGlue.draw_card_from_deck()
				cmd_text.add_text(">> 从牌堆中抽一张牌" + "\n")
			
			# 创造一张牌并放入手牌
			if cmd_edit.text == "add_card":
				
				flag = true
				
				var new_card : Card = CARD.instantiate()
				new_card.id = DeckGlue.get_id(new_card)
				new_card.time = randi_range(0,3)
				new_card.card_detail = str(randf())
				CalenderGlue.put_card_into_hand(new_card)
				if new_card.time == 0:
					new_card.time_type = Card.TimeType.RealTime
				else:
					new_card.time_type = Card.TimeType.Schedule
				new_card.card_type = randi_range(0,1) as Card.CardType
				var type_name : String = ""
				match new_card.card_type:
					Card.CardType.Medical:
						type_name = "医疗卡"
					Card.CardType.Activity:
						type_name = "活动卡"
				new_card._name = type_name + str(new_card.time)
				cmd_text.add_text(">> 创造一张空白牌放入手牌" + "\n")
			
			# 创造一个空buff
			if cmd_edit.text == "add_buff":
				
				flag = true
				
				var new_buff : Buff = BUFF.instantiate()
				PlayerInfoGlue.add_buff(new_buff)
				new_buff.buff_detail = str(randf())
				cmd_text.add_text(">> 创造一个空buff" + "\n")
			
			if flag == false:
				cmd_text.add_text(">> 无效命令，输入\"-h\"获取帮助" + "\n")
			
			cmd_edit.text = ""
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			is_dragging = true
			start_drag_position = self.global_position
			start_drag_mouse_position = get_viewport().get_mouse_position()
		if event.is_action_released("LeftClick"):
			is_dragging = false
	if event is InputEventMouseMotion:
		if is_dragging:
			current_drag_mouse_position = get_viewport().get_mouse_position()
			global_position = start_drag_position + current_drag_mouse_position - start_drag_mouse_position 

var mouse_in : bool = false

var start_drag_position : Vector2
var start_drag_mouse_position : Vector2
var current_drag_mouse_position : Vector2

var is_dragging : bool = false

func _on_mouse_entered() -> void:
	mouse_in = true


func _on_mouse_exited() -> void:
	mouse_in = false
