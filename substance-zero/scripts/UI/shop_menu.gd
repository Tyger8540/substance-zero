class_name ShopMenu
extends Control


@export var power_up:PackedScene
@export var melee_display:PackedScene
@export var target_display:PackedScene
@export var shield_display:PackedScene
@export var red_bottle_display:PackedScene
@export var blue_bottle_display:PackedScene
@export var shop_capacity: int

var power_ups_to_buy: Array[PowerUp]
var power_up_types: Array[Enums.Power_Up_Type]
var shopping: bool = false

@onready var powerup_container = $VBoxContainer/PowerupContainer


func _ready() -> void:
	_fill_shop()
	_update_displays()


func _process(delta) -> void:
	# check for pause input (esc)
	if Input.is_action_just_pressed("open_powerup_shop"):
		_fill_shop()
		_update_displays()
		_toggle_shopping()


func _fill_shop() -> void:
	for i in shop_capacity:
		var type = _pick_random_power_up_type()
		var lifespan: Enums.Power_Up_Lifespan
		
		if (
				type == Enums.Power_Up_Type.BUBBLE_SHIELD
				or type == Enums.Power_Up_Type.GRENADE
		):
			lifespan = Enums.Power_Up_Lifespan.SINGLE_USE
		else:
			lifespan = Enums.Power_Up_Lifespan.values().pick_random()
		
		var new_power_up = power_up.instantiate() as PowerUp
		new_power_up.initialize(lifespan, type)
		
		power_ups_to_buy[i] = new_power_up


# pick random power up type (different from powerup types already in shop)
func _pick_random_power_up_type() -> Enums.Power_Up_Type:
	var type = Enums.Power_Up_Type.values().pick_random()
	for power_up in power_ups_to_buy:
		if type == power_up.type:
			_pick_random_power_up_type()
	
	return type
	
	
func _update_displays() -> void:
	for power_up in power_ups_to_buy:
		match power_up.type:	
			Enums.Power_Up_Type.MELEE_DAMAGE:
				var new_melee = melee_display.instantiate()
				powerup_container.add_child(new_melee)
			Enums.Power_Up_Type.RANGED_DAMAGE:
				var new_ranged = target_display.instantiate()
				powerup_container.add_child(new_ranged)
			Enums.Power_Up_Type.HEALTH_BOOST:
				var new_health_boost = red_bottle_display.instantiate()
				powerup_container.add_child(new_health_boost)
			Enums.Power_Up_Type.SHIELD_BOOST:
				var new_shield_boost = blue_bottle_display.instantiate()
				powerup_container.add_child(new_shield_boost)
			Enums.Power_Up_Type.BUBBLE_SHIELD:
				var new_bubble_shield = shield_display.instantiate()
				powerup_container.add_child(new_bubble_shield)
			Enums.Power_Up_Type.GRENADE:
				var new_grenade = shield_display.instantiate()
				powerup_container.add_child(new_grenade)
	

func _on_exit_button_pressed() -> void:
	# exit shop menu
	_toggle_shopping()


func _toggle_shopping() -> void:
	print("toggle shopping")
	if shopping:
		self.hide()
		get_tree().paused = false
	else:
		self.show()
		get_tree().paused = true
