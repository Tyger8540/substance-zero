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

var _enemies:Array[Enemy]

# from exercise 1
@onready var _player = $"../Player"

# from exercise 3
@onready var _enemy_spawn = $"../EnemySpawn"
@onready var _enemy:PackedScene = load("res://scenes/enemy.tscn")


func spawn_enemies() -> void:
	# modified from exercise 3
	
	# initialize new enemy
	var new_enemy:Enemy = _enemy.instantiate() as Enemy
	
	# add to enemy to enemy spawn node and enemy array
	_enemy_spawn.add_child(new_enemy)
	_enemies.append(new_enemy)
	
	# equip a weapon for the enemy
	new_enemy.equip_melee()
	
	# set enemy's position relative to the player
	new_enemy.global_position.x = _player.global_position.x + _enemy_offset_x
	new_enemy.global_position.y = _player.global_position.y + _enemy_offset_y
	
	# make sure enemy does not overlap with another enemy
	_enemy_offset_x += _offset_x
	_enemy_offset_y += _offset_y
		

func move_enemies() -> void:
	print('moving enemies')
	

func _physics_process(_delta):
	if _player.health > 0.0 and len(_enemies) < max_enemies:
		spawn_enemies()
	
	#if len(_enemy_spawn.get_children()) > 0:
		#move_enemies()
