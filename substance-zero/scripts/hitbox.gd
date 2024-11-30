# modified from exercise 1
class_name HitBox
extends Area2D


@export var damage:float = 10.0


func _init() -> void:
	collision_layer = 0
	collision_mask = 8
	area_entered.connect(_on_area_entered)


func _on_area_entered(hurtbox:HurtBox) -> void:
	
	if hurtbox.name == "Projectile":
		print("projectile hit")
		hurtbox.queue_free()
		return
	
	# if more than one projectile is on the screen then the name is @Area2D@i where i is an integer
	
	if owner.has_method("take_damage") and hurtbox.get_owner().attacking:
		owner.take_damage(damage)
		print(owner.name)
		print("took damage")
		print(owner.health)
		print()
