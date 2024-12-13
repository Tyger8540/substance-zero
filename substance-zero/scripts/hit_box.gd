# modified from exercise 1
class_name HitBox
extends Area2D

var player_hurtboxes:Array[String] = ["PlayerMelee", "PlayerProjectile", "PlayerPiercingProjectile"]
var enemy_hurtboxes:Array[String] = ["EnemyMelee", "EnemyProjectile", "EnemyPiercingProjectile"]


func _init() -> void:
	#collision_layer = 0
	#collision_mask = 8
	area_entered.connect(_on_area_entered)


func _on_area_entered(hurtbox:HurtBox) -> void:
	
	if hurtbox.name_of_hurtbox == "Grenade":
		owner.take_damage(hurtbox.damage)
		
	# check if enemy is damaging player
	if hurtbox.name_of_hurtbox in enemy_hurtboxes and owner.char_name == "Player":
		if hurtbox.name_of_hurtbox == "PlayerMelee":
			owner.take_damage(hurtbox.damage + 10.0 * PowerUpInventory.power_up_level[Enums.Power_Up_Lifespan.PERMANENT][Enums.Power_Up_Type.MELEE_DAMAGE])
		elif hurtbox.name_of_hurtbox == "PlayerProjectile":
			owner.take_damage(hurtbox.damage + 10.0 * PowerUpInventory.power_up_level[Enums.Power_Up_Lifespan.PERMANENT][Enums.Power_Up_Type.RANGED_DAMAGE])
		elif hurtbox.name_of_hurtbox == "PlayerPiercingProjectile":
			owner.take_damage(hurtbox.damage)
		
	# check if player is damaging enemy
	if hurtbox.name_of_hurtbox in player_hurtboxes and owner.char_name == "Enemy":
		if hurtbox.name_of_hurtbox == "EnemyMelee":
			owner.take_damage(hurtbox.damage + 10.0 * PowerUpInventory.power_up_level[Enums.Power_Up_Lifespan.PERMANENT][Enums.Power_Up_Type.MELEE_DAMAGE])
		elif hurtbox.name_of_hurtbox == "EnemyProjectile":
			owner.take_damage(hurtbox.damage + 10.0 * PowerUpInventory.power_up_level[Enums.Power_Up_Lifespan.PERMANENT][Enums.Power_Up_Type.RANGED_DAMAGE])
		elif hurtbox.name_of_hurtbox == "EnemyPiercingProjectile":
			owner.take_damage(hurtbox.damage)
			
