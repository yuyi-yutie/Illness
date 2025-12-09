extends Node
class_name Buff

enum BUFFTYPE {
	EveryDay ,
	EveryWeek ,
	EveryMonth ,
	EveryYear
}

func execute() -> void:
	pass

func kill() -> void:
	queue_free()
