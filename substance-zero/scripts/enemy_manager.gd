# modified from exercise 1
class_name EnemyManager
extends Node

var command_dict = {
	0: DurativeIdleCommand,
	1: DurativeMoveLeftCommand,
	2: DurativeMoveRightCommand,
	3: DurativeMoveUpCommand,
	4: DurativeMoveDownCommand,
}

var weapon_dict = {
	0: Enemy.Weapons.MELEE,
	1: Enemy.Weapons.LASER_GUN,
	2: Enemy.Weapons.PIERCING_GUN,
	3: Enemy.Weapons.ALL_DIRECTIONS_GUN
}

@export var max_enemies:int = 10
@export var _min_offset:int = 50.0
@export var _offset_scale:int = 5.0

var command_status:Command.Status
var _enemies_in_each_room:Array[Array] = []
var _appended:bool = false

var _spawned_enemies:int = 0

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
	var random_weapon:int = randi_range(0, len(weapon_dict) - 1)
	new_enemy.current_weapon = weapon_dict[random_weapon]
	
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
	_enemies_in_each_room[random_room_index].append(new_enemy)
	
	
func _give_enemies_commands(enemy:Enemy) -> void:
	# randomize commands
	var random_command:int = randi_range(0, len(command_dict) - 1)
	enemy.enemy_cmd_list.push_back(command_dict[random_command].new(0.66))
	enemy.enemy_cmd_list.push_back(AttackCommand.new())
	
	
func _room_is_empty(room:Array) -> bool:
	var number_of_enemies:int = 0
	for enemy in room:
		if is_instance_valid(enemy):
			number_of_enemies += 1
	return number_of_enemies == 0
	
	
func _get_next_non_empty_room(enemies_in_each_room:Array[Array]) -> int:
	var room_index:int = 0
	for room in enemies_in_each_room:
		if not _room_is_empty(room):
			return room_index
		room_index += 1
	return -1
	
	
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
		
	if Global.rooms_spawned and not _appended:
		# initialize enemy array
		for room in Global.room_position_array:
			_enemies_in_each_room.append([])
		_appended = true
		
		
	if _player.health > 0.0 and _spawned_enemies < max_enemies and Global.rooms_spawned:
		_spawn_enemy()
		_spawned_enemies += 1
		
	# give enemies commands
	for enemy in _enemy_spawn.get_children():
		if len(enemy.enemy_cmd_list) == 0:
			_give_enemies_commands(enemy)
			
		_execute_commands(enemy)
	
	if Global.rooms_spawned:
		
		# if player has defeated all enemies in the current room, teleport to the next room
		if _room_is_empty(_enemies_in_each_room[Global.current_room]) or Input.is_action_pressed("skip_room"):
			Global.current_room = _get_next_non_empty_room(_enemies_in_each_room)
			# if player has defeated all enemies, teleport to boss room
			if Global.current_room == -1:
				Global.room_position_array = []
				get_tree().change_scene_to_file("res://scenes/Bosses/Boss_Rooms/Boss1_Room.tscn")
			else:
				_player.global_position.x = Global.room_position_array[Global.current_room].x + _min_offset
				_player.global_position.y = Global.room_position_array[Global.current_room].y + _min_offset
