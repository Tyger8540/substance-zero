extends Node

# PLAYER VARIABLES
var health: float
var character_speed: float
var level: int


func save_player_state(player: Player) -> void:
	health = player.health
	character_speed = player.character_speed
	level = player.level


func load_player_state(player: Player) -> void:
	player.health = health
	player.character_speed = character_speed
	player.level = level
