extends Node

@export var time_label : Label
@export var photos_label : Label
@export var group_label : Label

func _ready():
	photos_label.text = "You took " + str(GameManager.photos_count) + " photos"
	group_label.text = "Participant group: " + str(GameManager.group)

func _on_button_pressed():
	get_tree().quit()
