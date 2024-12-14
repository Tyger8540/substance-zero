# modified from exercise 1
class_name BossBattleManager
extends Node

var command_dict = {
	0: DurativeIdleCommand,
	1: DurativeMoveLeftCommand,
	2: DurativeMoveRightCommand,
	3: DurativeMoveUpCommand,
	4: DurativeMoveDownCommand,
}

@onready var _player = $"../Player"
@onready var _boss = $"../Boss1"
var boss_fight := false

# Boss 1 attack pattern:
	# Move between the four corners of the map
	# Stops when it reaches 
	
func _ready():
	# set enemy weapon
	# by default it is the melee
	_boss.current_weapon = _boss.Weapons.LASER_GUN


func _physics_process(delta: float) -> void:
	# check if player or boss is dead
	if not _player or not _boss:
		return
	# if is still fighting boss
	if boss_fight:
		if not _player.dead and not _boss.dead:
			
			if Global.planet_number == 0:
				_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(2.25))
				_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.01))
				_burst_attack()
				_boss.enemy_cmd_list.push_back(DurativeMoveUpCommand.new(1.25))
				_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.01))
				_burst_attack()
				_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(2.25))
				_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.01))
				_burst_attack()
				_boss.enemy_cmd_list.push_back(DurativeMoveDownCommand.new(1.25))
				_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.01))
				_burst_attack()
			else:
				var random_command:int = randi_range(0, len(command_dict) - 1)
				_burst_attack()
				_boss.enemy_cmd_list.push_back(command_dict[random_command].new(0.66))
				_burst_attack()


func _burst_attack() -> void:
	_boss.enemy_cmd_list.push_back(AttackCommand.new())
	_boss.enemy_cmd_list.push_back(DurativeIdleCommand.new(0.1))
	_boss.enemy_cmd_list.push_back(AttackCommand.new())
	_boss.enemy_cmd_list.push_back(DurativeIdleCommand.new(0.1))
	_boss.enemy_cmd_list.push_back(AttackCommand.new())
	_boss.enemy_cmd_list.push_back(DurativeIdleCommand.new(1))
