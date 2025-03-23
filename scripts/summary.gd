extends Node

@export var time_label : Label
@export var photos_label : Label
@export var group_label : Label

func get_time():
	var time : int = round(GameManager.end_time - GameManager.start_time)
	var seconds = time%60
	var minutes = (time/60)%60
	var hours = (time/60)/60
	if (hours == 0 and minutes == 0):
		return "%02d seconds" % [seconds]
	elif (hours == 0):
		return "%02d:%02d" % [minutes, seconds]
	else:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]

func _ready():
	time_label.text = "You played for " + get_time()
	photos_label.text = "You took " + str(GameManager.photos_count) + " photos"
	group_label.text = "Participant group: " + str(GameManager.group)

func _on_button_pressed():
	get_tree().quit()
