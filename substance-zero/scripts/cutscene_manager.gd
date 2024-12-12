# from exercise 1
class_name CutSceneManager
extends Node


var player_cmd_list:Array[Command]

var command_status:Command.Status
var _cutscene_played:bool = false

@onready var _player:= $"../Player"


func start_cutscene() -> void:
	_cutscene_played = true
	_player.unbind_player_input_commands()
	
	# stop player movement
	_player.velocity.x = 0
	_player.velocity.y = 0


func end_cutscene() -> void:
	_cutscene_played = false
	_player.bind_player_input_commands()
	

func _physics_process(_delta):
	
	if _cutscene_played and len(player_cmd_list) == 0:
		end_cutscene()
	
	# otherwise execute commands
	for command in player_cmd_list:
		command_status = player_cmd_list.front().execute(_player)
		if command_status == Command.Status.DONE:
			player_cmd_list.pop_front()
		
