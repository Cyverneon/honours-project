extends Node

@export_group("References")
@export var viewport : Viewport

@export var photo_album : Control
@export var photo_popup : TextureRect
@export var controls : Label

var summary_scene := "res://scenes/summary.tscn"

var photos : Array[ImageTexture]
var in_album : bool = false

func take_photo():
	var image = viewport.get_texture().get_image()
	var texture = ImageTexture.create_from_image(image)
	photos.append(texture)
	GameManager.photos_count += 1
	photo_popup.set_texture(texture)

func hide_photo_album():
	in_album = false
	photo_album.hide()
	controls.show()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func show_photo_album():
	in_album = true
	photo_album.show()
	controls.hide()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event.is_action_pressed("photo"):
		take_photo()
	if event.is_action_pressed("album"):
		if in_album:
			hide_photo_album()
		else:
			show_photo_album()

func _ready():
	hide_photo_album()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_finish_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(summary_scene)
