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

@export var time : int
@export var _name : String

var card_id : int

var label_time : int = -1 :
	get:
		return label_time
	set(value):
		label_time = value
		time_label.text = str(label_time)

var label_name : String = "CARD" :
	get:
		return label_name
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
