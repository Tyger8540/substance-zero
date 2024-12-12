class_name CutSceneBoss1
extends CutSceneManager

@onready var player: Player = $"../Player"
@onready var boss: Boss1 = $"%Boss1"
@onready var xxyla: Xxyla = $"../Xxyla"
var dialogue_queue:Array[Array] = []

# cutscene: when entering boss 1 room
func start_cutscene() -> void:
	super()
	
	dialogue_queue.push_back([player, "I think I’ve found my target."])
	dialogue_queue.push_back([xxyla, "You won’t stop us. I’ve just finished collecting my data. I’ll leave you with the Commander."])
	dialogue_queue.push_back([boss,  "I’ll take care of this one."])
	dialogue_queue.push_back([player,  "You will try."])
	
	# NPC (Xxyla) actions:
	xxyla.global_position = Vector2(500, 500)
	#xxyla.enemy_cmd_list.push_back(DurativeIdleCommand.new(1.0))
	#xxyla.enemy_cmd_list.push_back(DurativeDialogueCommand.new("You won’t stop us. I’ve just finished collecting my data. I’ll leave you with the Commander.", 2.0))
	
	# boss1 actions:
	boss.enemy_cmd_list.clear()
	boss.global_position = Vector2(700, 500)
	#boss.enemy_cmd_list.push_back(DurativeIdleCommand.new(4.0))
	#boss.enemy_cmd_list.push_back(DurativeDialogueCommand.new("I’ll take care of this one."))
	
	# player actions:
	#player_cmd_list.push_back(DurativeDialogueCommand.new("I think I’ve found my target."))
	#player_cmd_list.push_back(DurativeIdleCommand.new(10.0))
	#player_cmd_list.push_back(DurativeIdleCommand.new(5.0))
	#player_cmd_list.push_back(DurativeDialogueCommand.new("You will try."))


func _physics_process(_delta):
	if _cutscene_played and len(dialogue_queue) == 0:
		end_cutscene()
	
	# otherwise execute commands
	for command in dialogue_queue:
		var new_dialogue = DurativeDialogueCommand.new(dialogue_queue.front()[1])
		command_status = new_dialogue.execute(dialogue_queue.front()[0])
		if command_status == Command.Status.DONE:
			player_cmd_list.pop_front()
