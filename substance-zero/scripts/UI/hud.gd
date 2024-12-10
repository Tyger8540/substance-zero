class_name Hud
extends Control


@export var melee_display:PackedScene
@export var target_display:PackedScene
@export var shield_display:PackedScene
@export var thrown_display:PackedScene
@export var red_bottle_display:PackedScene
@export var blue_bottle_display:PackedScene

@onready var power_up_container = $MarginContainer/HBoxContainer/PowerupContainer
@onready var credits_label = $MarginContainer/CounterVBox/CreditsLabel
@onready var deaths_label = $MarginContainer/CounterVBox/DeathsLabel
@onready var player: Player = get_node("../../Player")


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass

func _update_power_up_displays() -> void:
	for power_up in player.power_ups:
		match power_up.type:	
			Enums.Power_Up_Type.MELEE_DAMAGE:
				var new_melee = melee_display.instantiate() as MeleePowerUpShopDisplay
				new_melee.power_up = power_up
				power_up_container.add_child(new_melee)
			Enums.Power_Up_Type.RANGED_DAMAGE:
				var new_ranged = target_display.instantiate() as TargetPowerUpShopDisplay
				new_ranged.power_up = power_up
				power_up_container.add_child(new_ranged)
			Enums.Power_Up_Type.HEALTH_BOOST:
				var new_health_boost = red_bottle_display.instantiate() as RedBottlePowerUpShopDisplay
				new_health_boost.power_up = power_up
				power_up_container.add_child(new_health_boost)
			Enums.Power_Up_Type.SHIELD_BOOST:
				var new_shield_boost = blue_bottle_display.instantiate() as BlueBottlePowerUpShopDisplay
				new_shield_boost.power_up = power_up
				power_up_container.add_child(new_shield_boost)
			Enums.Power_Up_Type.BUBBLE_SHIELD:
				var new_bubble_shield = shield_display.instantiate() as ShieldPowerUpShopDisplay
				new_bubble_shield.power_up = power_up
				power_up_container.add_child(new_bubble_shield)
			Enums.Power_Up_Type.GRENADE:
				var new_grenade = thrown_display.instantiate() as ThrownPowerUpShopDisplay
				new_grenade.power_up = power_up
				power_up_container.add_child(new_grenade)
	

# Update player credits and shop credits display	
func _update_player_credits(power_up: PowerUp) -> void:
	player.credits -= power_up.price
	credits_label.text = "%d Credits" % player.credits
