class_name Alien
extends Enemy

@onready var scientist_animation_tree: AnimationTree = $Scientist_AnimationTree

func _ready():
	scientist_animation_tree.active = true
	
func _physics_process(delta: float) -> void:
	_manage_animation_tree_state()
	super(delta)

func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		scientist_animation_tree["parameters/conditions/idle"] = false
		scientist_animation_tree["parameters/conditions/moving"] = true
	else:
		scientist_animation_tree["parameters/conditions/idle"] = true
		scientist_animation_tree["parameters/conditions/moving"] = false
	#toggles
	if attacking:
		scientist_animation_tree["parameters/conditions/attacking"] = true
		attacking = false
	else:
		scientist_animation_tree["parameters/conditions/attacking"] = false
		
	#if damaged:
		#scientist_animation_tree["parameters/conditions/damaged"] = true
		#damaged = false
	#else:
		#scientist_animation_tree["parameters/conditions/damaged"] = false
