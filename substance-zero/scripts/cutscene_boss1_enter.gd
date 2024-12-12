class_name CutSceneBoss1
extends CutSceneManager

@onready var player: Player = $"../Player"
@onready var boss: Boss1 = $"../Boss1"
@onready var xxyla: Xxyla = $"../Xxyla"


# cutscene: when entering boss 1 room
func start_cutscene() -> void:
	super()
	
	# NPC (Xxyla) actions:
	xxyla.global_position = Vector2(500, 500)
	xxyla.enemy_cmd_list.push_back(DurativeIdleCommand.new(1.0))
	
	# boss1 actions:
	boss.enemy_cmd_list.clear()
	boss.global_position = Vector2(700, 500)
	
	# player actions:
	player_cmd_list.push_back(DurativeDialogueCommand.new("I think I’ve found my target."))
	player_cmd_list.push_back(DurativeIdleCommand.new(10.0))
