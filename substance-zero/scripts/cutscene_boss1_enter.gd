class_name CutSceneBoss1
extends CutSceneManager

@onready var player: Player = $"../Player"
@onready var boss: Boss1 = $"../Boss1"
@onready var xxyla: Xxyla = $"../Xxyla"
@onready var boss_battle_manager: BossBattleManager = $"../BossBattleManager"
var dialogue_queue:Array[Array] = []
var executing = false
var new_dialogue:DurativeDialogueCommand

# cutscene: when entering boss 1 room
func start_cutscene() -> void:
	super()
	$"../UI".visible = false
	xxyla.facing = xxyla.Facing.RIGHTwwww
	
	# NPC (Xxyla) actions:
	
	# boss1 actions:
	boss.enemy_cmd_list.clear()


func end_cutscene() -> void:
	super()
	boss_battle_manager.boss_fight = true
	xxyla.visible = false
	$"../UI".visible = true


func _physics_process(_delta):
	if _cutscene_played and len(dialogue_queue) == 0:
		end_cutscene()
	
	# player actions:
	player_cmd_list.push_back(DurativeDialogueCommand.new("I think I’ve found my target."))
	player_cmd_list.push_back(DurativeIdleCommand.new(10.0))
