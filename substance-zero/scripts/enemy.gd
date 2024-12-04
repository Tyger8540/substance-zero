class_name Enemy
extends Character

var enemy_cmd_list:Array[Command]
@onready var projectile_spawn = $"../../ProjectileSpawn"

func _ready():
	pass


func _physics_process(delta):
	super(delta)
	
