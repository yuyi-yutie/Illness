extends Panel
class_name ExecuteCardPanel

var parent : ExcutePanel

func initialize(parameter : ExcutePanel) -> void:
	parent = parameter
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered() -> void:
	print("111")
