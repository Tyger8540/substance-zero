class_name Enemy
extends Character

var facing_dict = {
	0:Facing.LEFT,
	1:Facing.RIGHT,
	2:Facing.UP,
	3:Facing.DOWN
}

var enemy_cmd_list:Array[Command]
# from exercise 3
@onready var projectile_spawn = $"../../ProjectileSpawn"


func _ready():
	pass


func _physics_process(delta):
	super(delta)
	
