extends Node

@export_group("References")
@export var texture_rect : TextureRect
@export var viewport : Viewport

func take_photo():
	var image = viewport.get_texture().get_image()
	var texture = ImageTexture.create_from_image(image)
	texture_rect.set_texture(texture)

func _input(event):
	if event.is_action_pressed("photo"):
		take_photo()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
