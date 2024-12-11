class_name PlayerHUD
extends Control


@export var melee_display:PackedScene
@export var target_display:PackedScene
@export var shield_display:PackedScene
@export var thrown_display:PackedScene
@export var red_bottle_display:PackedScene
@export var blue_bottle_display:PackedScene

@onready var power_up_container = $MarginContainer/HBoxContainer/PowerupContainer
@onready var shield_bar = $MarginContainer/HBoxContainer/HealthShieldVBox/ShieldHBox/ShieldBar
@onready var health_bar = $MarginContainer/HBoxContainer/HealthShieldVBox/HealthHBox/HealthBar
@onready var shield_label = $MarginContainer/HBoxContainer/HealthShieldVBox/ShieldHBox/ShieldLabel
@onready var health_label = $MarginContainer/HBoxContainer/HealthShieldVBox/HealthHBox/HealthLabel
@onready var credits_label = $MarginContainer/HBoxContainer/CounterVBox/CreditsLabel
@onready var deaths_label = $MarginContainer/HBoxContainer/CounterVBox/DeathsLabel
@onready var player: Player = get_node("../../Player")


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if player.dead:
		set_process(false)
		
	_update_shield_health_displays()
	_update_power_up_displays()
	_update_credits_deaths_labels()
	

#func _create_power_up_displays() -> void:
	#for power_up in player.power_ups:
		#match power_up.type:	
			#Enums.Power_Up_Type.MELEE_DAMAGE:
				#var new_melee = melee_display.instantiate() as MeleePowerupHUD
				#new_melee.power_up = power_up
				#power_up_container.add_child(new_melee)
			#Enums.Power_Up_Type.RANGED_DAMAGE:
				#var new_ranged = target_display.instantiate() as TargetPowerupHUD
				#new_ranged.power_up = power_up
				#power_up_container.add_child(new_ranged)
			#Enums.Power_Up_Type.HEALTH_BOOST:
				#var new_health_boost = red_bottle_display.instantiate() as RedBottlePowerUpShopDisplay
				#new_health_boost.power_up = power_up
				#power_up_container.add_child(new_health_boost)
			#Enums.Power_Up_Type.SHIELD_BOOST:
				#var new_shield_boost = blue_bottle_display.instantiate() as BlueBottlePowerUpShopDisplay
				#new_shield_boost.power_up = power_up
				#power_up_container.add_child(new_shield_boost)
			#Enums.Power_Up_Type.BUBBLE_SHIELD:
				#var new_bubble_shield = shield_display.instantiate() as ShieldPowerUpShopDisplay
				#new_bubble_shield.power_up = power_up
				#power_up_container.add_child(new_bubble_shield)
			#Enums.Power_Up_Type.GRENADE:
				#var new_grenade = thrown_display.instantiate() as ThrownPowerUpShopDisplay
				#new_grenade.power_up = power_up
				#power_up_container.add_child(new_grenade)
#

func _update_power_up_displays() -> void:
	for power_up_display in power_up_container.get_children():
		var label = power_up_display.get_child(0)
		label.text = "1"
	
	
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
