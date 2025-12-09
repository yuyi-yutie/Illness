extends Panel
class_name ExecutePanel

var parent : CalenderPanel

enum EXECUTEPANELTYPE {
	Medical ,
	Activity
}

@onready var box_container: Control = $BoxContainer
@export var type : EXECUTEPANELTYPE

var has_box : bool = false

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	if type == EXECUTEPANELTYPE.Medical:
		HandToExecutePanel.medical_panel = self
	if type == EXECUTEPANELTYPE.Activity:
		HandToExecutePanel.activity_panel = self
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
