class_name PowerUp
extends Node

@export var lifespan: Enums.Power_Up_Lifespan
@export var type: Enums.Power_Up_Type
@export var price: int


func initialize(_lifespan: Enums.Power_Up_Lifespan, _type: Enums.Power_Up_Type) -> void:
	lifespan = _lifespan
	type = _type


func _on_area_2d_body_entered(body: Node2D) -> void:
	PowerUpInventory.power_up_level[lifespan][type] += 1
	var power_up_name: String
	if type == Enums.Power_Up_Type.MELEE_DAMAGE:
		%PowerupLabel.show_text("You picked up a melee damage powerup!")
	else:
		%PowerupLabel.show_text("You picked up a projectile damage powerup!")
	print(PowerUpInventory.power_up_level[lifespan][type])
	queue_free()
