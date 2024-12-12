# modified from exercise 1
class_name EnemyManager
extends Node

@export var max_enemies:int = 10
@export var _min_offset:int = 50.0
@export var _offset_scale:int = 5.0

var command_status:Command.Status
var enemies_in_each_room:Array[Array] = []
var appended:bool = false

# from exercise 1
@onready var _player = $"../Player"

# from exercise 3
@onready var _enemy_spawn = $"../EnemySpawn"
@onready var _enemy:PackedScene = load("res://scenes/alien.tscn")


func _spawn_enemy() -> void:
	# modified from exercise 3
	
	# initialize new enemy
	var new_enemy:Enemy = _enemy.instantiate() as Enemy
	
	# add to enemy to enemy spawn
	_enemy_spawn.add_child(new_enemy)
	
	# set enemy weapon
	# by default it is the melee
	new_enemy.current_weapon = new_enemy.Weapons.LASER_GUN
	
	# handle position
	
	# pick a random room
	var random_room_index:int = randi_range(0, len(Global.room_position_array) - 1)
	
	# pick a random offset
	new_enemy.global_position = Global.room_position_array[random_room_index]
	var offset_x:int = randi_range(_min_offset, Global.dimensions_array[random_room_index].x * _offset_scale)
	var offset_y:int = randi_range(_min_offset, Global.dimensions_array[random_room_index].y * _offset_scale)
	new_enemy.global_position.x += offset_x
	new_enemy.global_position.y += offset_y
	
	# add enemy to room count of enemies
	enemies_in_each_room[random_room_index].append(new_enemy)
	
	
func _give_enemies_commands(enemy:Enemy) -> void:
	enemy.enemy_cmd_list.push_back(DurativeIdleCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveDownCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveUpCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveUpCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(AttackCommand.new())
	
	
# from exercise 1
func _execute_commands(enemy:Enemy) -> void:
	for command in enemy.enemy_cmd_list:
		command_status = enemy.enemy_cmd_list.front().execute(enemy)
		if command_status == Command.Status.DONE:
			enemy.enemy_cmd_list.pop_front()
	
	
func _physics_process(_delta):
	# check if player is dead
	if not _player:
		return
		
	if Global.rooms_spawned and not appended:
		# initialize enemy array
		for room in Global.room_position_array:
			enemies_in_each_room.append([])
		appended = true
		
		
	if _player.health > 0.0 and len(_enemy_spawn.get_children()) < max_enemies and Global.rooms_spawned:
			
		_spawn_enemy()
		
	# give enemies commands
	for enemy in _enemy_spawn.get_children():
		if len(enemy.enemy_cmd_list) == 0:
			_give_enemies_commands(enemy)
			
		_execute_commands(enemy)
		
	print(enemies_in_each_room)
	# check if the room is empty
	for room in enemies_in_each_room:
		for enemy in room:
			if enemy:
				return
		print("teleport")
		# teleport player to next room
		#Global.room_position_array.pop_back()
		#_player.global_position = Global.room_position_array[len(Global.room_position_array) - 1]
			
