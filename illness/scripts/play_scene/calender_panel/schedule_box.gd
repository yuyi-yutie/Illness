extends Control
class_name ScheduleBox

enum MedicalOrActivity {
	Medical ,
	Activity
}

enum SBOrAB {
	#sb是schedule_box形态，ab就是ab形态
	Sb ,
	Ab
}

@export var type : MedicalOrActivity
@export var sb_or_ab : SBOrAB
@export var ready_rect : TextureRect

var parent : MedicalAndActivityPanel

func initialize(parameter : MedicalAndActivityPanel) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	match sb_or_ab:
		SBOrAB.Sb:
			sb_initialize()
		SBOrAB.Ab:
			ab_initialize()

#这是schedule_box的初始化
func sb_initialize() -> void:
	match type:
		MedicalOrActivity.Medical:
			CalenderGlue.medical_schedule_box_position = self.global_position
		MedicalOrActivity.Activity:
			CalenderGlue.activity_schedule_box_position = self.global_position

#这是ab形态的初始化
func ab_initialize() -> void:
	match type:
		MedicalOrActivity.Medical:
			CalenderGlue.ab_medical_schedule_box_position = self.global_position
			CalenderGlue.schedule_ready_rect_medical = ready_rect
			ready_rect.visible = false
		MedicalOrActivity.Activity:
			CalenderGlue.ab_activity_schedule_box_position = self.global_position
			CalenderGlue.schedule_ready_rect_activity = ready_rect
			ready_rect.visible = false
