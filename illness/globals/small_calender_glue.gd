extends Node

var year : int = 1111:
	set(value):
		year = value
		for month_progress in month_progress_array:
			month_progress.value = 0
var month : int = 1:
	set(value):
		month = value
		if month == 13:
			year += 1
			month = 1
var week : int = 1:
	set(value):
		week = value
		if week == 5:
			month += 1
			week = 1
		date_label_text = str(year) + "年" + str(month) + "月" + str(week) + "周"
		month_progress_array[month-1].value = week * 25

var date_label : Label
var month_progress_array : Array[ProgressBar]

var date_label_text : String = "":
	set(value):
		date_label_text = value
		date_label.text = date_label_text
