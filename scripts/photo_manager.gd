extends Node

@export_group("References")
@export var viewport : Viewport

@export var photo_album : Control
@export var photo_popup : TextureRect
@export var main_photo : TextureRect
@export var controls : Label
@export var left_button : Button
@export var right_button : Button
@export var finish_button : Button
@export var counter : Label

@onready var reticle = get_tree().root.get_node("Reticle")

@export_group("Config")
@export var popup_fade_time : float = 1.0
@export var photos_threshold : int = 4

var summary_scene := "res://scenes/summary.tscn"

var photos : Array[ImageTexture]
var in_album : bool = false

var is_popup_fadeout : bool = true
var popup_fadeout_timer : float = 0.0

var album_index : int = 0

func take_photo():
	var image = viewport.get_texture().get_image()
	var texture = ImageTexture.create_from_image(image)
	photos.append(texture)
	GameManager.photos_count += 1
	photo_popup.set_texture(texture)
	is_popup_fadeout = true
	popup_fadeout_timer = 2.0

func hide_photo_album():
	in_album = false
	photo_album.hide()
	controls.show()
	reticle.show()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED	

func show_photo_album():
	in_album = true
	photo_album.show()
	controls.hide()
	reticle.hide()
	get_tree().paused = true
	popup_fadeout_timer = 0.0
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func check_side_buttons():
	left_button.disabled = (album_index == 0)
	right_button.disabled = (album_index >= (photos.size()-1))

func check_photos_threshold():
	if (photos.size() < photos_threshold):
		finish_button.text = "You need to take at least 4 photos before finishing"
		finish_button.disabled = true
	else:
		finish_button.text = "Finish Game"
		finish_button.disabled = false

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
		album_index = photos.size() - 1
		main_photo.texture = photos[album_index]
		update_counter()
	check_side_buttons()
	check_photos_threshold()

func photo_popup_fadeout(delta):
	if is_popup_fadeout:
		popup_fadeout_timer -= (delta/popup_fade_time)
		photo_popup.modulate = Color(1.0, 1.0, 1.0, popup_fadeout_timer)
		if (popup_fadeout_timer <= 0):
			is_popup_fadeout = false

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
	photo_popup_fadeout(delta)

func _on_left_button_pressed():
	switch_photo(album_index-1)

func _on_right_button_pressed():
	switch_photo(album_index+1)

func _on_back_button_pressed():
	hide_photo_album()

func _on_finish_button_pressed():
	get_tree().paused = false
	GameManager.set_end_time()
	get_tree().change_scene_to_file(summary_scene)
