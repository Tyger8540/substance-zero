# modified from exercise 1
class_name AttackCommand
extends Command


func execute(character:Character) -> Status:
	# check if the character is dead
	if not character:
		return Status.DONE
		
	character.attacking = true
	if character.current_weapon == character.Weapons.MELEE:
		character.attack_with_melee()
	elif character.current_weapon == character.Weapons.LASER_GUN:
		character.fire_laser_gun(character.projectile_spawn)
		
	return Status.DONE
	
