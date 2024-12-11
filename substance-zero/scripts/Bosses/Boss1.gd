class_name Boss1
extends Enemy 

var target : Character
var following := false
var _death:bool = false

@export var boss_projectile:PackedScene = load("res://scenes/weapons/boss_projectile.tscn")
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	health = 100
	target = $"../Player"
	character_speed = 400
	projectile_spawn = $"../ProjectileSpawn"


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


func fire_laser_gun(projectile_spawn:Node, starting_position_x:float=global_position.x, starting_position_y:float=global_position.y, length:float=default_projectile_length, damage:float=default_projectile_damage, speed:float=default_projectile_speed, offset:float=default_projectile_offset, duration:float=default_projectile_duration) -> void:
	# check if the target is dead
	if not target:
		return
		
	# modified from exercise 3
	
	# make a projectile spec
	var projectile_spec:ProjectileSpec = ProjectileSpec.new()
	projectile_spec.length = length
	projectile_spec.damage = damage
	projectile_spec.speed = speed
	projectile_spec.offset = offset
	projectile_spec.duration = duration
	
	# make a projectile factory to build the projectile
	var projectile_factory:BossProjectileFactory = BossProjectileFactory.new()
	
	# make a projectile
	var new_projectile:BossProjectile = projectile_factory.build(projectile_spec, self, target) as BossProjectile
	
	# add projectile to projectile spawn
	projectile_spawn.add_child(new_projectile)
	
	# set position of projectile
	handle_position(new_projectile, offset)
	
	# handle facing
	set_facing_of_hurtbox(new_projectile, facing)


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
		
	if damaged:
		animation_tree["parameters/conditions/damaged"] = true
		damaged = false
	else:
		animation_tree["parameters/conditions/damaged"] = false
