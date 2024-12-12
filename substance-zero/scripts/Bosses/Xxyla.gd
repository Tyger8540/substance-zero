class_name Xxyla
extends Enemy

@onready var animation_tree: AnimationTree = $AnimationTree
var _death:bool = false

func _ready() -> void:
	char_name = "XXYLA"
	animation_tree.active = true
	

func _process(_delta):
	if _death:
		animation_tree.active = false
		$Sprite2D.visible = false
		return
		
	if len(enemy_cmd_list)>0:
		var command_status:Command.Status = enemy_cmd_list.front().execute(self)
		if Command.Status.DONE == command_status:
			#cmd_list
			enemy_cmd_list.pop_front()
		
	_manage_animation_tree_state()


func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/moving"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/moving"] = false
