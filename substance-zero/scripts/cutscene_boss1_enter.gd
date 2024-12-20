class_name CutSceneBoss1
extends CutSceneManager

const _PLAYER_OFFSET = 500.0

@onready var player: Player = $"../Player"
@onready var boss: Boss1 = $"../Boss1"
#@onready var xxyla: Xxyla = $"../Xxyla"
@onready var boss_battle_manager: BossBattleManager = $"../BossBattleManager"
var dialogue_queue:Array[Array] = []
var executing = false
var new_dialogue:DurativeDialogueCommand

# cutscene: when entering boss 1 room
func start_cutscene() -> void:
	super()
	$"../UI".visible = false
	
	# set player position
	player.global_position.x = boss.global_position.x - _PLAYER_OFFSET
	player.global_position.y = boss.global_position.y
	
	dialogue_queue.push_back([boss,  "What?"])
	dialogue_queue.push_back([boss,  "How did you get here?"])
	dialogue_queue.push_back([player, "I think I’ve found my target."])
	dialogue_queue.push_back([boss,  "You are too weak stop us. I’ll destory you."])
	dialogue_queue.push_back([player,  "You can certainly try."])
	
	# boss1 actions:
	boss.enemy_cmd_list.clear()


func end_cutscene() -> void:
	super()
	boss_battle_manager.boss_fight = true
	$"../UI".visible = true
	
  # NOTE Commented out for merge, was in main before
	# NPC (Xxyla) actions:
	#xxyla.global_position = Vector2(500, 500)
	
	# boss1 actions:
	#boss.enemy_cmd_list.clear()
	#boss.global_position = Vector2(700, 500)


func _physics_process(_delta):
	if _cutscene_played and len(dialogue_queue) == 0:
		end_cutscene()
	
	# otherwise execute commands
	if not dialogue_queue.is_empty():
		if not executing:
			new_dialogue = DurativeDialogueCommand.new(dialogue_queue.front()[1])
			executing = true
		if new_dialogue != null:
			command_status = new_dialogue.execute(dialogue_queue.front()[0])
			if command_status == Command.Status.DONE:
				dialogue_queue.pop_front()
				executing = false
