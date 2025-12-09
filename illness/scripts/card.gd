#要把卡放入手牌请按照下方流程
#const CARD = preload("res://scenes/card.tscn")
#hand_panel = HandToExecutePanel.hand_panel
#var new_card : Card = CARD.instantiate()
#hand_panel.add_child(new_card)
#new_card._name = "???"
#new_card.time = 0
#new_card.initialize(hand_panel)

extends Node2D
class_name Card

@onready var time_label: Label = $CardFace/TimePanel/TimeLabel
@onready var name_label: Label = $CardFace/NamePanel/NameLabel

@onready var card_buff_manager: CardBuffManager = $CardBuffManager

@export var time : int
@export var _name : String
@export var card_detail : String
@export var type : CARDTYPE

enum CARDTYPE {
	Medical ,
	Activity
}

var card_id : int

var label_time : int = -1 :
	set(value):
		label_time = value
		time_label.text = str(label_time)

var label_name : String = "CARD" :
	set(value):
		label_name = value
		name_label.text = label_name

@onready var card_face: Panel = $CardFace

var parent : HandPanel
func initialize(parameter : HandPanel) -> void:
	parent = parameter
	
	HandToExecutePanel.card_size = card_face.size
	
	parent.arrange_cards()
	
	label_time = time
	label_name = _name

var mouse_in : bool = false

func _on_card_face_mouse_entered() -> void:
	CardToDetail.hover_card = self
	HandToExecutePanel.hover_card = self
	mouse_in = true

func _on_card_face_mouse_exited() -> void:
	if CardToDetail.hover_card == self:
		CardToDetail.hover_card = null
	if HandToExecutePanel.hover_card == self:
		HandToExecutePanel.hover_card = null
	mouse_in = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			if mouse_in:
				card_buff_manager.execute_buff()
