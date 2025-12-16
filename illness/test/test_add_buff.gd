extends Button

const BUFF = preload("uid://uimtbx032j36")

func _on_button_down() -> void:
	var new_buff : Buff = BUFF.instantiate()
	PlayerInfoGlue.add_buff(new_buff)
	new_buff.buff_detail = str(randf())
