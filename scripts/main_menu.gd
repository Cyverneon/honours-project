extends Node

var loading_scene := "res://scenes/loading.tscn"

@export var group_label : Label

func _ready():
	group_label.text = "Build for participant group " + str(GameManager.group)

func load_game():
	get_tree().change_scene_to_file(loading_scene)

func _on_button_pressed():
	load_game()
