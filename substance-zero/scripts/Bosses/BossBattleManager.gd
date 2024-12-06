class_name BossBattleManager
extends Node

@onready var _player = $"../Player"
@onready var _boss = $"../Boss1"

# modified from excise 1
# Boss 1 attack pattern:
	# Move between the four corners of the map
	# Stops when it reaches 
	
func _ready():
	# set enemy weapon
	# by default it is the melee
	_boss.current_weapon = _boss.Weapons.LASER_GUN


func _physics_process(delta: float) -> void:
	# if is still fighting boss
		if not _player.dead and not _boss.dead:
			_boss.enemy_cmd_list.push_back(DurativeMoveUpCommand.new(1.25))
			_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.01))
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(2.25))
			_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.01))
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(DurativeMoveDownCommand.new(1.25))
			_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.01))
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(2.25))
			_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.01))
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())
			_boss.enemy_cmd_list.push_back(AttackCommand.new())


func _handle_facing() -> void:
	if _player.Facing.LEFT:
		_boss.Facing.LEFT
	elif _player.Facing.RIGHT:
		_boss.Facing.RIGHT
	#elif hazard.facing == hazard.Facing.UP:
		#hazard.global_position.y += _offset
	#elif hazard.facing == hazard.Facing.DOWN:
		#hazard.global_position.y -= _offset
