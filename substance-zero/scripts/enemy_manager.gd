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
	enemies_in_each_room[random_room_index].append(new_enemy)
	
	
func _give_enemies_commands(enemy:Enemy) -> void:
	# randomize commands
	var random_command:int = randi_range(0, len(command_dict) - 1)
	enemy.enemy_cmd_list.push_back(command_dict[random_command].new(0.66))
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
	# check if the room is empty
	#if Global.rooms_spawned:
		#if Input.is_action_just_pressed("skip_room"):
			#Global.room_position_array.pop_back()
			#if len(Global.room_position_array) - 1 < 0:
				#get_tree().change_scene_to_file("res://scenes/space_scene.tscn")
				#return
			#_player.global_position = Global.room_position_array[len(Global.room_position_array) - 1] + Vector2(30.0, 30.0)
		#else:
			#for room in enemies_in_each_room:
				#for enemy in room:
					#if enemy and is_instance_valid(enemy):
						#return
				##print("teleport")
				## teleport player to next room
				#print("Global room position array:")
				#print(Global.room_position_array)
				#Global.room_position_array.pop_back()
				#print("len")
				#print(len(Global.room_position_array) - 1)
				#if len(Global.room_position_array) - 1 < 0:
					#get_tree().change_scene_to_file("res://scenes/space_scene.tscn")
					#return
				#_player.global_position = Global.room_position_array[len(Global.room_position_array) - 1] + Vector2(30.0, 30.0)
				
	if Global.rooms_spawned:
		
		if Input.is_action_just_pressed("skip_room"):
			Global.room_position_array.pop_back()
			#print(len(Global.room_position_array))
			
			if len(Global.room_position_array) <= 0:
				#get_tree().change_scene_to_file("res://scenes/space_scene.tscn")
				get_tree().change_scene_to_file("res://scenes/Bosses/Boss_Rooms/Boss1_Room.tscn")
				return
				
			_player.global_position = Global.room_position_array[len(Global.room_position_array) - 1] + Vector2(30.0, 30.0)
			
		# check if current room is empty
		var current_room:Array = enemies_in_each_room[len(Global.room_position_array) - 1]
		var number_of_enemies:int = 0
		for enemy in current_room:
			if is_instance_valid(enemy):
				number_of_enemies += 1
				
		if number_of_enemies == 0:
			Global.room_position_array.pop_back()
			
			
			# check if room position array is empty
			# if it is teleport to spaceship
			if len(Global.room_position_array) <= 0:
				get_tree().change_scene_to_file("res://scenes/Bosses/Boss_Rooms/Boss1_Room.tscn")
			# otherwise teleport to next room
			else:
				_player.global_position.x = Global.room_position_array[len(Global.room_position_array) - 1].x + _min_offset
				_player.global_position.y = Global.room_position_array[len(Global.room_position_array) - 1].y + _min_offset
				
				# check if room position array is of size 1
				# if it is teleport to boss room and start cutscene
				if len(Global.room_position_array) == 1:
					pass
					#get_tree().change_scene_to_file("res://scenes/space_scene.tscn")
			
	
