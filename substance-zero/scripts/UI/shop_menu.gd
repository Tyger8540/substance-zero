extends Control


@export var power_up:PackedScene
@export var shop_capacity: int

var power_ups_to_buy: Array[PowerUp]
var power_up_types: Array[Enums.Power_Up_Type]


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
				pass
				# create display
			Enums.Power_Up_Type.RANGE_DAMAGE:
				pass
			Enums.Power_Up_Type.HEALTH_BOOST:
				pass
			Enums.Power_Up_Type.BUBBLE_SHIELD:
				pass
	
func _ready() -> void:
	_fill_shop()


func _process(delta: float) -> void:
	pass
