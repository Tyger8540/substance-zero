extends CharacterBody2D

@export var speed: float = 200.0
@onready var animation_tree: AnimationTree = $AnimationTree

var attacking:bool = false
var _damaged:bool = false


func _ready():
	animation_tree.active = true


func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if (Input.is_action_just_pressed("attack")):
		attacking = true;
	velocity = input_dir * speed


func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity * delta)
	
	_manage_animation_tree_state()


func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/moving"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/moving"] = false
	#toggles
	if attacking:
		animation_tree["parameters/conditions/attacking"] = true
		attacking = false
	else:
		animation_tree["parameters/conditions/attacking"] = false
		
	#if _damaged:
		#animation_tree["parameters/conditions/damaged"] = true
		#_damaged = false
	#else:
		#animation_tree["parameters/conditions/damaged"] = false
