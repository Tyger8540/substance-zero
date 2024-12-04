# modified from exercise 1
class_name EnemyManager
extends Node

@export var max_enemies:int = 3

# offset relative to the player
@export var _enemy_offset_x = 250.0
@export var _enemy_offset_y = -45.0

# offset relative to a nearby enemy
@export var _offset_x = 150.0
@export var _offset_y = 150.0

var command_status:Command.Status

# from exercise 1
@onready var _player = $"../Player"

# from exercise 3
@onready var _enemy_spawn = $"../EnemySpawn"
@onready var _enemy:PackedScene = load("res://scenes/alien.tscn")


func spawn_enemy() -> void:
	# modified from exercise 3
	
	# initialize new enemy
	var new_enemy:Enemy = _enemy.instantiate() as Enemy
	
	# add to enemy to enemy spawn
	_enemy_spawn.add_child(new_enemy)
	
	# set enemy weapon
	# by default it is the melee
	new_enemy.current_weapon = new_enemy.Weapons.LASER_GUN
	
	# set enemy's position relative to the player
	new_enemy.global_position.x = _player.global_position.x + _enemy_offset_x
	new_enemy.global_position.y = _player.global_position.y + _enemy_offset_y
	
	# make sure enemy does not overlap with another enemy
	_enemy_offset_x += _offset_x
	_enemy_offset_y += _offset_y
	
		

func _give_enemies_commands(enemy:Enemy) -> void:
	enemy.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveUpCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(DurativeMoveDownCommand.new(0.66))
	enemy.enemy_cmd_list.push_back(AttackCommand.new())
	
	
# from exercise 1
func _execute_commands(enemy:Enemy) -> void:
	for command in enemy.enemy_cmd_list:
		command_status = enemy.enemy_cmd_list.front().execute(enemy)
		if command_status == Command.Status.DONE:
			enemy.enemy_cmd_list.pop_front()
	
	
func _physics_process(_delta):
	if _player.health > 0.0 and len(_enemy_spawn.get_children()) < max_enemies:
		spawn_enemy()
	
	for enemy in _enemy_spawn.get_children():
		if len(enemy.enemy_cmd_list) == 0:
			_give_enemies_commands(enemy)
			
		_execute_commands(enemy)
		
		
