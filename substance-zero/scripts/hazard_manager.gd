# modified from exercise 1
class_name HazardManager
extends Node

const _MAX_HAZARDS = 10
@export var _min_offset:int = 100.0
@export var _offset_scale:int = 50.0
@export var _delay:float = 1.0
@export var _speed:float = 10.0
@export var _duration:float = 10.0
var command_status:Command.Status
var _hazards:Array[Enemy]

# from exercise 1
@onready var _player:= $"../Player"

# from exercise 3
@onready var _enemy_spawn = $"../EnemySpawn"
@onready var _enemy:PackedScene = load("res://scenes/enemy.tscn")
	
	
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
	
	# handle position
	
	# pick a random room
	var random_room_index:int = randi_range(0, len(Global.room_position_array) - 1)
	
	# pick a random position on a random border to spawn on
	var random_border:int = randi_range(0, 3)
	
	# top border is 0
	# left border is 1
	# bottom border is 2
	# right border is 3
	
	# set facing and position of hazard
	new_hazard.global_position = Global.room_position_array[random_room_index]
	var offset_x:int = randi_range(_min_offset, Global.dimensions_array[random_room_index].x * _offset_scale)
	var offset_y:int = randi_range(_min_offset, Global.dimensions_array[random_room_index].y * _offset_scale)
	new_hazard.global_position.x += offset_x
	new_hazard.global_position.y += offset_y
	
	if random_border == 0:
		#print("top border")
		new_hazard.facing = new_hazard.Facing.DOWN
		#new_hazard.global_position.x += offset_x
	elif random_border == 1:
		#print("left border")
		new_hazard.facing = new_hazard.Facing.RIGHT
		#new_hazard.global_position.x += offset_y
	elif random_border == 2:
		#print("bottom border")
		new_hazard.facing = new_hazard.Facing.UP
		#new_hazard.global_position.x += offset_x
		#new_hazard.global_position.x += offset_y
	elif random_border == 3:
		#print("right border")
		new_hazard.facing = new_hazard.Facing.LEFT
		#new_hazard.global_position.x += offset_x
		#new_hazard.global_position.x += offset_y
	
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
			SoundManager.playSound("laser")
			
			
func _physics_process(_delta):
	# check if player is dead
	if not _player:
		return
		
	if _player.health > 0.0 and len(_hazards) < _MAX_HAZARDS:
		print("spawning hazard")
		_spawn_hazard()
		
	for hazard in _hazards:
		if len(hazard.enemy_cmd_list) == 0:
			hazard.enemy_cmd_list.push_back(AttackCommand.new())
			hazard.enemy_cmd_list.push_back(DurativeIdleCommand.new(_delay))
			
		_execute_commands(hazard)
		
