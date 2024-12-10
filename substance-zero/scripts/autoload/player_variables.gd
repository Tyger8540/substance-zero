extends Node

# PLAYER VARIABLES
var health: float
var character_speed: float
var level: int
var credits: int
var power_ups: Array[PowerUp]


func save_player_state(player: Player) -> void:
	health = player.health
	character_speed = player.character_speed
	level = player.level
	credits = player.credits
	power_ups = player.power_ups


func load_player_state(player: Player) -> void:
	player.health = health
	player.character_speed = character_speed
	player.level = level
	player.credits = credits
	player.power_ups = power_ups
