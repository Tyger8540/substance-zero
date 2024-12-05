class_name BossBattleManager
extends Node

@onready var _player = $"../Player"
@onready var _boss = $"../Boss1"


# modified from excise 1
func _process(delta):
	# if is still fighting boss
		if not _player.dead and not _boss.dead:
			if len(_boss.cmd_list) < 3:
				# move and attack base on distance from player
				var distance = _player.global_position - _boss.global_position
				if distance.x < -200:
					_boss.enemy_cmd_list.push_back(DurativeMoveLeftCommand.new(0.001))
				elif distance.x > -50:
					_boss.enemy_cmd_list.push_back(DurativeMoveRightCommand.new(0.001))
				#elif abs(distance.x) > 30:
					#_boss.enemy_cmd_list.push_back(DurativeAttackCommand.new())
				else:
					_boss.enemy_cmd_list.push_back(DurativeIdleCommand.new(0.001))
