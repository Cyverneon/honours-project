extends Control

const target_scene = "res://scenes/main_scene.tscn"

var loading_status : int
var progress : Array[float]

@export var progress_bar : ProgressBar

func _ready():
	ResourceLoader.load_threaded_request(target_scene)

func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status(target_scene, progress)
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error! Couldn't load scene :(")
