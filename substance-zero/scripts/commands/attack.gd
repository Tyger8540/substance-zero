# modified from exercise 1
class_name AttackCommand
extends Command


func execute(character:Character) -> Status:
	character.attacking = true
	if character.primary_weapon == character.Weapons.LASER_GUN:
		# modified from exercise 3
		var new_projectile:Projectile = character.projectile.instantiate() as Projectile
		character.projectile_spawn.add_child(new_projectile)
		
		# set position of projectile
		new_projectile.global_position = character.global_position
		new_projectile.global_position.x += character.projectile_offset_x
		
		# handle direction
		if character.facing == character.Facing.RIGHT:
			new_projectile.facing = HurtBox.Facing.RIGHT
			
	return Status.DONE
