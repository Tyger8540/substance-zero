# modified from exercise 1
class_name HitBox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 8
	area_entered.connect(_on_area_entered)


func _on_area_entered(hurtbox:HurtBox) -> void:
	
	if hurtbox.name_of_hurtbox == "Melee":
		owner.take_damage(hurtbox.damage)
		
		print("melee hit")
		print(owner.name)
		print("took damage")
		print(owner.health)
		print()
		
	elif hurtbox.name_of_hurtbox == "Projectile":
		owner.take_damage(hurtbox.damage)
		hurtbox.queue_free()
		
		print("projectile hit")
		print(owner.name)
		print("took damage")
		print(owner.health)
		print()
		
