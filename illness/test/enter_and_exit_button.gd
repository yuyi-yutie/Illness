extends Button

var is_open : bool = true

var parent : CardDetailPanel

func initialize(parameter : CardDetailPanel) -> void:
	parent = parameter

func _on_button_down() -> void:
	match is_open:
		true:
			parent.position.x = parent.size.x - size.x
			parent.self_modulate.a = 0
		false:
			parent.position.x = 0
			parent.self_modulate.a = 1
	is_open = !is_open
	parent.card_container.visible = !parent.card_container.visible
	parent.card_detail.visible = !parent.card_detail.visible
