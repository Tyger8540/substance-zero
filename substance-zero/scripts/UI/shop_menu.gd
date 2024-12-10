class_name ShopMenu
extends Control


@export var power_up_scene:PackedScene
@export var melee_display:PackedScene
@export var target_display:PackedScene
@export var shield_display:PackedScene
@export var thrown_display:PackedScene
@export var red_bottle_display:PackedScene
@export var blue_bottle_display:PackedScene
@export var shop_capacity: int

var power_ups_to_buy: Array[PowerUp]
var shopping: bool = false

@onready var power_up_container = $VBoxContainer/PowerupContainer
@onready var credits_label = $PanelContainer/MarginContainer/CreditsLabel
@onready var player: Player = get_node("../Player")


func _ready() -> void:
	Signals.buying_power_up.connect(_on_buying_power_up)
	credits_label.text = "%d Credits" % player.credits


func _process(delta) -> void:
	# check for pause input (esc)
	if Input.is_action_just_pressed("open_powerup_shop"):
		refresh_shop()
		_toggle_shopping()


func refresh_shop() -> void:
	# Clear previous powerups in shop
	power_ups_to_buy.clear()
	for display in power_up_container.get_children():
		display.queue_free()
	
	# Fill shop with new random + unique powerups
	for i in shop_capacity:
		var type = _pick_random_power_up_type()
		var lifespan: Enums.Power_Up_Lifespan
		
		if (
				type == Enums.Power_Up_Type.BUBBLE_SHIELD
				or type == Enums.Power_Up_Type.GRENADE
		):
			# Lifespan is only single usefor "bubble shield" and "grenade"
			lifespan = Enums.Power_Up_Lifespan.SINGLE_USE
		else:
			# Otherwise, lifespan is permanent or room limited
			lifespan = randi_range(0, 1)
		
		var new_power_up = power_up_scene.instantiate() as PowerUp
		new_power_up.initialize(lifespan, type)
		
		power_ups_to_buy.append(new_power_up)
		
	_update_power_up_displays()
		

# pick random power up type (different from powerup types already in shop)
func _pick_random_power_up_type() -> Enums.Power_Up_Type:
	var type = Enums.Power_Up_Type.values().pick_random()
	for power_up in power_ups_to_buy:
		if type == power_up.type:
			type = _pick_random_power_up_type()
	
	return type
	
	
# Update shop displays based on power ups in the shop
func _update_power_up_displays() -> void:
	for power_up in power_ups_to_buy:
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
	

func _on_exit_button_pressed() -> void:
	# exit shop menu
	_toggle_shopping()


# Check if player has enough credits, then send gain power up signals
func _on_buying_power_up(power_up: PowerUp) -> void:
	if power_up.price <= player.credits:
		_update_player_credits(power_up)
		
		Signals.gain_power_up.emit(power_up)
		match power_up.type:	
			Enums.Power_Up_Type.MELEE_DAMAGE:
				Signals.gain_melee_power_up.emit()
			Enums.Power_Up_Type.RANGED_DAMAGE:
				Signals.gain_target_power_up.emit()
			Enums.Power_Up_Type.HEALTH_BOOST:
				Signals.gain_red_bottle_power_up.emit()
			Enums.Power_Up_Type.SHIELD_BOOST:
				Signals.gain_blue_bottle_power_up.emit()
			Enums.Power_Up_Type.BUBBLE_SHIELD:
				Signals.gain_shield_power_up.emit()
			Enums.Power_Up_Type.GRENADE:
				Signals.gain_thrown_power_up.emit()
	
	
func _toggle_shopping() -> void:
	if shopping:
		shopping = false
		self.hide()
		get_tree().paused = false
	else:
		shopping = true
		self.show()
		get_tree().paused = true
		
	Signals.shopping.emit(shopping)
