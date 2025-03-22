extends Resource

# amount of 'sub-branches'
@export var branches_count_min : int = 3
@export var branches_count_max : int = 5

# amount of sections of trunk that have branches
@export var height_min : int = 3
@export var height_max : int = 5

# length of branches
@export var branch_length_min : float = 0.4
@export var branch_length_max : float = 0.6

# amount that length decreases for 'sub-branches'
@export var branch_length_falloff_min : float = 0.75
@export var branch_length_falloff_max : float = 0.95

# amount rotation for branches
@export var branch_factor_min : float = 2.0
@export var branch_factor_max : float = 3.0

# min and max amount that branches are allowed to clump
@export var branch_clump_max_min : float = 0.45
@export var branch_clump_max_max : float = 0.45
@export var branch_clump_min_min : float = 0.4
@export var branch_clump_min_max : float = 0.4

# amount sub-branches flop down or flare up
@export var drop_amount_min : float = -0.05
@export var drop_amount_max : float = -0.15

# amount root branches flop down or flare up
@export var grow_amount_min : float = 0.05
@export var grow_amount_max : float = 0.3

# amount branches are swept to one side
@export var sweep_amount_min : float = -0.05
@export var sweep_amount_max : float = 0.05

# maxiumum radius of trunk and branches
@export var max_radius_min : float = 0.12
@export var max_radius_max : float = 0.16

# rate that the radius falls off
# higher value means thicker branches
@export var radius_falloff_rate_min : float = 0.65
@export var radius_falloff_rate_max : float = 0.75

# gaps between sections of trunk with branches
@export var climb_rate_min : float = 0.2
@export var climb_rate_max : float = 0.3

# add a kink in the trunk
@export var kink_min : float = -0.09
@export var kink_max : float = 0.09

# amount branches twist around trunk
# (0 means they're all on the same side of the tree)
@export var twist_min : float = 2
@export var twist_max : float = 4

# length of trunk before branches start
@export var length_min : float = 1
@export var length_max : float = 2.4

# min and max amount the bark colour can be tinted to a random colour
@export var bark_color_min : float = 0.0
@export var bark_color_max : float = 0.2

# min and max amount the twig colour can be tinted to a random colour
@export var twig_color_min : float = 0.0
@export var twig_color_max : float = 0.3
