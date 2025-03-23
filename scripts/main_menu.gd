extends Node

var loading_scene := "res://scenes/loading.tscn"

func load_game():
	get_tree().change_scene_to_file(loading_scene)

func _on_button_pressed():
	load_game()
