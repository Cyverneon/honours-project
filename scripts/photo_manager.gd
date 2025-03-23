extends Node

@export_group("References")
@export var viewport : Viewport

@export var photo_album : Control
@export var photo_popup : TextureRect
@export var main_photo : TextureRect
@export var controls : Label
@export var left_button : Button
@export var right_button : Button
@export var counter : Label

var summary_scene := "res://scenes/summary.tscn"

var photos : Array[ImageTexture]
var in_album : bool = false

var album_index : int = 0

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

func check_side_buttons():
	left_button.disabled = (album_index == 0)
	right_button.disabled = (album_index >= (photos.size()-1))

func update_counter():
	counter.text = "Photo: " + str(album_index+1) + " / Total: " + str(photos.size())

func switch_photo(new_index : int):
	if (new_index >= 0 and new_index < photos.size()):
		album_index = new_index
		main_photo.texture = photos[album_index]
		check_side_buttons()
		update_counter()

func load_photo_album():
	if photos.size() == 0:
		main_photo.texture = null
		album_index = 0
		counter.text = "Total: 0"
	else:
		main_photo.texture = photos[album_index]
		update_counter()
	check_side_buttons()

func _input(event):
	if event.is_action_pressed("photo"):
		if not in_album:
			take_photo()
	if event.is_action_pressed("album"):
		if in_album:
			hide_photo_album()
		else:
			show_photo_album()
			load_photo_album()

func _ready():
	hide_photo_album()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_left_button_pressed():
	switch_photo(album_index-1)

func _on_right_button_pressed():
	switch_photo(album_index+1)

func _on_back_button_pressed():
	hide_photo_album()

func _on_finish_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(summary_scene)
