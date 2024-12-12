extends Node

# PLAYER VARIABLES
var health: float
var shield: float
var total_health: float
var total_shield: float
var character_speed: float
var level: int
var deaths: int
var credits: int
var power_ups: Array[PowerUp]


func save_player_state(player: Player) -> void:
	health = player.health
	shield = player.shield
	total_health = player.total_health
	total_shield = player.total_shield
	character_speed = player.character_speed
	level = player.level
	deaths = player.deaths
	credits = player.credits
	power_ups = player.power_ups
	


func load_player_state(player: Player) -> void:
	player.health = health
	player.shield = shield
	player.total_health = total_health
	player.total_shield = total_shield
	player.character_speed = character_speed
	player.level = level
	player.deaths = deaths
	player.credits = credits
	player.power_ups = power_ups


func has_power_up(_type: Enums.Power_Up_Type) -> bool:
	for power_up in power_ups:
		if is_instance_valid(power_up) and power_up.type == _type:
			return true
	return false
