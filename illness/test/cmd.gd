extends Panel
class_name cmd

@export var cmd_text : RichTextLabel
@export var cmd_edit : LineEdit

var is_open : bool = true :
	set(value):
		is_open = value
		self.visible = is_open

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("CallCMD"):
			is_open = !is_open
		if event.is_action_pressed("CMDEnter"):
			cmd_text.add_text(">> " + cmd_edit.text + "\n")
			
			if cmd_edit.text == "-h":
				cmd_text.add_text("> 按下~键以关闭/打开控制台" + "\n")
				cmd_text.add_text("> 目前支持以下命令:" + "\n")
				cmd_text.add_text("    add_week  ->  周数+1" + "\n")
				cmd_text.add_text("    draw_card  ->  从牌堆中抽一张牌" + "\n")
			
			if cmd_edit.text == "add_week":
				SmallCalenderGlue.week += 1
				cmd_text.add_text("> 周数+1" + "\n")
			if cmd_edit.text == "draw_card":
				DeckGlue.draw_card_from_deck()
				cmd_text.add_text("> 从牌堆中抽一张牌" + "\n")
			
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
