extends Node2D
class_name Card

var tween : Tween
@onready var card_panel: Panel = $CardPanel


func _on_detect_area_mouse_entered() -> void:
	kill_tween()
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(card_panel , "scale" , Vector2.ONE * 1.15 , 0.15)

func _on_detect_area_mouse_exited() -> void:
	kill_tween()
	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(card_panel , "scale" , Vector2.ONE , 0.15)

func kill_tween() -> void:
	if tween and tween.is_running():
		tween.kill()
