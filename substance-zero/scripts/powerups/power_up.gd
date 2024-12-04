class_name PowerUp
extends Node

@export var lifespan: Enums.Power_Up_Lifespan
@export var type: Enums.Power_Up_Type


func initialize(_lifespan: Enums.Power_Up_Lifespan, _type: Enums.Power_Up_Type) -> void:
	lifespan = _lifespan
	type = _type


func _on_area_2d_body_entered(body: Node2D) -> void:
	PowerUpInventory.power_up_level[lifespan][type] += 1
	print(PowerUpInventory.power_up_level[lifespan][type])
	queue_free()
