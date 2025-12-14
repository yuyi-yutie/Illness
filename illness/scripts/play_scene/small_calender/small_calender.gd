extends Control
class_name SmallCalender

var parent : PlayScene

func initialize(parameter : PlayScene) -> void:
	parent = parameter
	for child in get_children():
		if child.has_method("initialize"):
			child.initialize(self)
	SmallCalenderGlue.date_label = date_label
	SmallCalenderGlue.month_progress_array = month_progress_array
	
	#测试
	SmallCalenderGlue.week = SmallCalenderGlue.week
	SmallCalenderGlue.month = SmallCalenderGlue.month
	SmallCalenderGlue.year = SmallCalenderGlue.year

@export var date_label : Label
@export var month_progress_array : Array[ProgressBar]
