# modified from exercise 1
class_name HazardManager
extends Node


const _MAX_HAZARDS = 3
@export var _offset:float = 200.0
@export var _delay:float = 1.0
@export var _speed:float = 10.0
@export var _duration:float = 1.0
var command_status:Command.Status
var _hazards:Array[Enemy]

# from exercise 1
@onready var _player:= $"../Player"

# from exercise 3
@onready var _enemy_spawn = $"../EnemySpawn"
@onready var _enemy:PackedScene = load("res://scenes/enemy.tscn")


func _handle_position(hazard:Enemy) -> void:
	hazard.global_position = _player.global_position
	if hazard.facing == hazard.Facing.LEFT:
		hazard.global_position.x += _offset
	elif hazard.facing == hazard.Facing.RIGHT:
		hazard.global_position.x -= _offset
	elif hazard.facing == hazard.Facing.UP:
		hazard.global_position.y += _offset
	elif hazard.facing == hazard.Facing.DOWN:
		hazard.global_position.y -= _offset
	
	_offset += 150.0
	

func _spawn_hazard() -> void:
	
	# modified from exercise 3
	
	# initialize new hazard
	var new_hazard:Enemy = _enemy.instantiate() as Enemy
	
	# add hazard to enemy_spawn
	_enemy_spawn.add_child(new_hazard)
	
	# set enemy weapon
	# by default it is the melee
	new_hazard.current_weapon = new_hazard.Weapons.LASER_GUN
	
	# increment number of hazards
	_hazards.append(new_hazard)
	
	# handle facing
	var random_facing_index:int = randi_range(0, len(_player.Facing) - 1)
	new_hazard.facing = new_hazard.facing_dict[random_facing_index]
	
	# handle position
	_handle_position(new_hazard)
	
	# set speed of hazard
	new_hazard.default_projectile_speed = _speed
	
	# set duration of hazard
	new_hazard.default_projectile_duration = _duration
	
	# get rid of hitbox
	for child in new_hazard.get_children():
		if child.name == "HitBox":
			new_hazard.remove_child(child)
	
	
# from exercise 1
func _execute_commands(hazard:Enemy) -> void:
	for command in hazard.enemy_cmd_list:
		command_status = hazard.enemy_cmd_list.front().execute(hazard)
		if command_status == Command.Status.DONE:
			hazard.enemy_cmd_list.pop_front()


func _physics_process(_delta):
	if _player.health > 0.0 and len(_hazards) < _MAX_HAZARDS:
		_spawn_hazard()
		
	for hazard in _hazards:
		if len(hazard.enemy_cmd_list) == 0:
			hazard.enemy_cmd_list.push_back(AttackCommand.new())
			hazard.enemy_cmd_list.push_back(DurativeIdleCommand.new(_delay))
			
		_execute_commands(hazard)
		
