extends Node

var group : int = 2

const param_ranges = preload("param_ranges.gd")
var params_normal : param_ranges = load("res://resources/param_ranges_group1.tres")
var params_extreme : param_ranges = load("res://resources/param_ranges_group2.tres")

func randomize_tree_params(tree : Tree3D, ranges : param_ranges):
	# generate a random colour
	# lerp it with white with a random weight based on min and max in param ranges
	# use this colour to tint the materials
	# this gives some controllable variety to tree colour
	tree.material_trunk.albedo_color = Color.WHITE.lerp(Color(randf(), randf(), randf()), randf_range(ranges.bark_color_min, ranges.bark_color_max))
	tree.material_twig.albedo_color = Color.WHITE.lerp(Color(randf(), randf(), randf()), randf_range(ranges.twig_color_min, ranges.twig_color_max))
	# generate random trunk parameter values based on min and max in param ranges
	tree.trunk_branches_count = randi_range(ranges.branches_count_min, ranges.branches_count_max)
	tree.trunk_height = randi_range(ranges.height_min, ranges.height_max)
	tree.trunk_branch_length = randf_range(ranges.branch_length_min, ranges.branch_length_max)
	tree.trunk_branch_length_falloff = randf_range(ranges.branch_length_falloff_min, ranges.branch_length_falloff_max)
	tree.trunk_branch_factor = randf_range(ranges.branch_factor_min, ranges.branch_factor_max)
	tree.trunk_branch_clump_max = randf_range(ranges.branch_clump_max_min, ranges.branch_clump_max_max)
	tree.trunk_branch_clump_min = randf_range(ranges.branch_clump_min_min, ranges.branch_clump_min_max)
	tree.trunk_drop_amount = randf_range(ranges.drop_amount_min, ranges.drop_amount_max)
	tree.trunk_grow_amount = randf_range(ranges.grow_amount_min, ranges.grow_amount_max)
	tree.trunk_sweep_amount = randf_range(ranges.sweep_amount_min, ranges.sweep_amount_max)
	tree.trunk_max_radius = randf_range(ranges.max_radius_min, ranges.max_radius_max)
	tree.trunk_radius_falloff_rate = randf_range(ranges.radius_falloff_rate_min, ranges.radius_falloff_rate_max)
	tree.trunk_climb_rate = randf_range(ranges.climb_rate_min, ranges.climb_rate_max)
	tree.trunk_kink = randf_range(ranges.kink_min, ranges.kink_max)
	tree.trunk_twist = randf_range(ranges.twist_min, ranges.twist_max)
	tree.trunk_length = randf_range(ranges.length_min, ranges.length_max)

func create_and_return_tree_static_body():
	var static_body = StaticBody3D.new()
	var collision_shape = CollisionShape3D.new()
	var cylinder = CylinderShape3D.new()
	cylinder.height = 6
	collision_shape.shape = cylinder
	static_body.add_child(collision_shape)
	return static_body

func create_tree(pos : Vector3, ranges : param_ranges):
	var tree = Tree3D.new()
	
	# fixed parameter values
	tree.trunk_segments = 6
	#tree.twig_enable = false # TEMP FOR DEBUGGING
	tree.position = pos
	tree.trunk_uv_multiplier = 1
	
	#materials
	tree.material_trunk = load("res://materials/bark_material.tres").duplicate()
	tree.material_twig = load("res://materials/leaf_material.tres").duplicate()

	# randomized parameters
	randomize_tree_params(tree, ranges)
	
	#collider
	tree.add_child(create_and_return_tree_static_body())

	add_child(tree)

func spawn_trees():
	for child in get_children():
		if child is Marker3D:
			if group == 1:
				create_tree(child.position, params_normal)
			elif group == 2:
				if (randf() < 0.5):
					create_tree(child.position, params_extreme)
				else:
					create_tree(child.position, params_normal)

func _ready():
	spawn_trees()
