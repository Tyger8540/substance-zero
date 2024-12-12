#class_name Boss1
#extends Enemy
#
#@onready var animation_tree: AnimationTree = $Scientist_AnimationTree
#
#func _ready():
	#animation_tree.active = true
	#
#func _physics_process(delta: float) -> void:
	#_manage_animation_tree_state()
	#super(delta)
#
#func _manage_animation_tree_state() -> void:
	#if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		#animation_tree["parameters/conditions/idle"] = false
		#animation_tree["parameters/conditions/moving"] = true
	#else:
		#animation_tree["parameters/conditions/idle"] = true
		#animation_tree["parameters/conditions/moving"] = false
	##toggles
	#if attacking:
		#animation_tree["parameters/conditions/attacking"] = true
		#attacking = false
	#else:
		#animation_tree["parameters/conditions/attacking"] = false
		#
	##if damaged:
		##animation_tree["parameters/conditions/damaged"] = true
		##damaged = false
	##else:
		##animation_tree["parameters/conditions/damaged"] = false
