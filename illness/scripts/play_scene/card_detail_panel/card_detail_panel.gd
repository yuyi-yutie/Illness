extends Control
class_name CardDetail

@export var detail_label: Label

@export var fake_name_label : Label
@export var fake_time_label : Label
@export var fake_picture : TextureRect
@export var fake_panel : Panel

@export var detail_panel : Panel

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	CardGlue.card_detail_label = detail_label
	CardGlue.fake_card_panel = fake_panel
	CardGlue.fake_card_name_label = fake_name_label
	CardGlue.fake_card_time_label = fake_time_label
	CardGlue.fake_card_picture = fake_picture

var is_open : bool = true

func _on_open_and_close_button_button_down() -> void:
	if is_open:
		is_open = false
		detail_panel.visible = false
		position.x += detail_panel.size.x
	else:
		is_open = true
		detail_panel.visible = true
		position.x -= detail_panel.size.x
