extends Panel
class_name cmd

var is_open : bool = true :
	set(value):
		is_open = value
		self.visible = is_open

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("CallCMD"):
			is_open = !is_open
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
