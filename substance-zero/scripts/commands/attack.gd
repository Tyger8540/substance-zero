# modified from exercise 1
class_name AttackCommand
extends Command

#@onready var projectile_spawn = $"../ProjectileSpawn"


func execute(character:Character) -> Status:
	if character.current_weapon == character.Weapons.MELEE:
		character.attack_with_melee()
	elif character.current_weapon == character.Weapons.LASER_GUN:
		character.fire_laser_gun(character.projectile_spawn)
		
	return Status.DONE
	
