extends Node

const CALENDER_BOX = preload("uid://6phraos5uw6a")


var card_size : Vector2
var hand_panel : HandPanel

var medical_box_container : Control
var activity_box_container : Control

var medical_panel : ExecutePanel:
	set(value):
		medical_panel = value
		medical_box_container = medical_panel.box_container
var activity_panel : ExecutePanel:
	set(value):
		activity_panel = value
		activity_box_container = activity_panel.box_container

var medical_occupy_time : int = 1
var activity_occupy_time : int = 0
#用于标识两个面板已占用的时间

var hover_card : Card:
	set(value):
		hover_card = value
		var box : Control = CALENDER_BOX.instantiate()
		if hover_card != null and hover_card.time > 0 and hover_card.type == hover_card.CARDTYPE.Medical and hover_card.time + medical_occupy_time <= 7: 
			box.scale.x = (hover_card.time - 1) * 1.25 + 1
			box.position.x = medical_occupy_time * 125
			medical_box_container.add_child(box)
			medical_panel.has_box = true
		elif hover_card != null and hover_card.time > 0 and hover_card.type == hover_card.CARDTYPE.Activity and hover_card.time + activity_occupy_time <= 7: 
			box.scale.x = (hover_card.time - 1) * 1.25 + 1
			box.position.x = activity_occupy_time * 125
			activity_box_container.add_child(box)
			activity_panel.has_box = true
		if hover_card == null:
			if medical_panel.has_box:
				medical_box_container.get_child(0).queue_free()
				medical_panel.has_box = false
			if activity_panel.has_box:
				activity_box_container.get_child(0).queue_free()
				activity_panel.has_box = false
