extends Node

#管理卡牌详情/悬浮/点击的全局脚本

var card_detail_label : Label
var fake_card_name_label : Label
var fake_card_time_label : Label
var fake_card_picture : TextureRect
var fake_card_panel : Panel

var current_hover_card : Card = null :
	set(value):
		current_hover_card = value
		if current_hover_card != null:
			fake_card_panel.visible = true
			card_detail_label.text = current_hover_card.card_detail
			fake_card_name_label.text = current_hover_card._name
			fake_card_time_label.text = str(current_hover_card.time)
			fake_card_picture.texture = current_hover_card.card_picture.texture
		else:
			fake_card_panel.visible = false
			card_detail_label.text = ""

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LeftClick"):
			if current_hover_card:
				current_hover_card.click()
