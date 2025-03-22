extends Node

var group : int = 2

const param_ranges = preload("param_ranges.gd")
var params : param_ranges

func create_tree(pos : Vector3):
	var tree = Tree3D.new()
	
	# fixed parameters
	tree.trunk_segments = 8
	tree.material_trunk = load("res://materials/bark_material.tres")
	tree.twig_enable = false # TEMP FOR DEBUGGING
	tree.position = pos
	
	# randomized parameters
	tree.trunk_branches_count = randi_range(params.branches_count_min, params.branches_count_max)

	return tree

func spawn_trees():
	for child in get_children():
		if child is Node3D:
			add_child(create_tree(child.position))

func _ready():
	if group == 1:
		params = load("res://resources/param_ranges_group1.tres")
	else:
		params = load("res://resources/param_ranges_group2.tres")
		
	spawn_trees()
