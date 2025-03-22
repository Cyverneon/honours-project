extends Node

var group : int = 1

const param_ranges = preload("param_ranges.gd")
var params : param_ranges

func create_tree(pos : Vector3):
	var tree = Tree3D.new()
	
	# fixed parameters
	tree.trunk_segments = 6
	tree.material_trunk = load("res://materials/bark_material.tres")
	tree.material_twig = load("res://materials/leaf_material.tres")
	#tree.twig_enable = false # TEMP FOR DEBUGGING
	tree.position = pos
	tree.trunk_uv_multiplier = 1
	
	# randomized parameters
	tree.trunk_branches_count = randi_range(params.branches_count_min, params.branches_count_max)
	tree.trunk_height = randi_range(params.height_min, params.height_max)
	tree.trunk_branch_length = randf_range(params.branch_length_min, params.branch_length_max)
	tree.trunk_branch_length_falloff = randf_range(params.branch_length_falloff_min, params.branch_length_falloff_max)
	tree.trunk_branch_factor = randf_range(params.branch_factor_min, params.branch_factor_max)
	tree.trunk_branch_clump_max = randf_range(params.branch_clump_max_min, params.branch_clump_max_max)
	tree.trunk_branch_clump_min = randf_range(params.branch_clump_min_min, params.branch_clump_min_max)
	tree.trunk_drop_amount = randf_range(params.drop_amount_min, params.drop_amount_max)
	tree.trunk_grow_amount = randf_range(params.grow_amount_min, params.grow_amount_max)
	tree.trunk_sweep_amount = randf_range(params.sweep_amount_min, params.sweep_amount_max)
	tree.trunk_max_radius = randf_range(params.max_radius_min, params.max_radius_max)
	tree.trunk_radius_falloff_rate = randf_range(params.radius_falloff_rate_min, params.radius_falloff_rate_max)
	tree.trunk_climb_rate = randf_range(params.climb_rate_min, params.climb_rate_max)
	tree.trunk_kink = randf_range(params.kink_min, params.kink_max)
	tree.trunk_twist = randf_range(params.twist_min, params.twist_max)
	tree.trunk_length = randf_range(params.length_min, params.length_max)

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
