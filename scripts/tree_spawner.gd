extends Node

func spawn_trees():
	var tree = Tree3D.new()
	add_child(tree)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_trees()
