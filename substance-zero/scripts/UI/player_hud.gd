class_name PlayerHUD
extends Control


@export var melee_display:PackedScene
@export var target_display:PackedScene
@export var shield_display:PackedScene
@export var thrown_display:PackedScene
@export var boots_display:PackedScene

var player_power_ups: Array[PowerUp] = []

@onready var power_up_container = $MarginContainer/HBoxContainer/PowerupContainer
@onready var shield_bar = $MarginContainer/HBoxContainer/HealthShieldVBox/ShieldHBox/ShieldBar
@onready var health_bar = $MarginContainer/HBoxContainer/HealthShieldVBox/HealthHBox/HealthBar
@onready var shield_label = $MarginContainer/HBoxContainer/HealthShieldVBox/ShieldHBox/ShieldLabel
@onready var health_label = $MarginContainer/HBoxContainer/HealthShieldVBox/HealthHBox/HealthLabel
@onready var credits_label = $MarginContainer/HBoxContainer/CounterVBox/CreditsLabel
@onready var deaths_label = $MarginContainer/HBoxContainer/CounterVBox/DeathsLabel
@onready var player: Player = get_node("../../Player")


func _ready() -> void:
	set_process(true)


func _process(delta: float) -> void:
	if player.dead:
		set_process(false)
	
	if _update_power_ups_if_outdated():
		_create_power_up_displays()
		
	_update_shield_health_displays()
	_update_power_up_displays()
	_update_credits_deaths_labels()
	

func _update_power_ups_if_outdated() -> bool:
	if player_power_ups != player.power_ups:
		print("power ups different")
		player_power_ups = player.power_ups
		return true
	
	return false
	
	
func _create_power_up_displays() -> void:
	for power_up in player_power_ups:
		match power_up.type:	
			Enums.Power_Up_Type.MELEE_DAMAGE:
				var new_melee = melee_display.instantiate()
				new_melee.power_up = power_up
				power_up_container.add_child(new_melee)
			Enums.Power_Up_Type.RANGED_DAMAGE:
				var new_ranged = target_display.instantiate()
				new_ranged.power_up = power_up
				power_up_container.add_child(new_ranged)
			Enums.Power_Up_Type.BUBBLE_SHIELD:
				var new_bubble_shield = shield_display.instantiate()
				new_bubble_shield.power_up = power_up
				power_up_container.add_child(new_bubble_shield)
			Enums.Power_Up_Type.GRENADE:
				var new_grenade = thrown_display.instantiate()
				new_grenade.power_up = power_up
				power_up_container.add_child(new_grenade)
			Enums.Power_Up_Type.EXPLODING_DASH:
				var new_exploding_dash = boots_display.instantiate()
				new_exploding_dash.power_up = power_up
				power_up_container.add_child(new_exploding_dash)
			_:
				pass


func _update_power_up_displays() -> void:
	for power_up_display in power_up_container.get_children():
		var label = power_up_display.get_child(0)
		
		label.text = str(power_up_display.power_up.uses)
	
	
func _update_shield_health_displays() -> void:
	shield_label.text = "%d/%d" % [player.shield, player.total_shield]
	health_label.text = "%d/%d" % [player.health, player.total_health]
	
	shield_bar.max_value = player.total_shield
	health_bar.max_value = player.total_health
	shield_bar.value = player.shield
	health_bar.value = player.health
	

# Update credits and deaths labels
func _update_credits_deaths_labels() -> void:
	credits_label.text = "%d" % player.credits
	deaths_label.text = "%d" % player.deaths
