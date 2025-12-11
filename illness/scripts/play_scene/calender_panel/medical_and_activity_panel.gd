extends Control
class_name MedicalAndActivityPanel

enum MedicalOrActivity{
	Medical ,
	Activity
}

@export var type : MedicalOrActivity

var parent : CalenderPanel

func initialize(parameter : CalenderPanel) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
