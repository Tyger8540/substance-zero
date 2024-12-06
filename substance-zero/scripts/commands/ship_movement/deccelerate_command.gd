class_name DeccelerateCommand
extends Command

# TODO need to make work
func execute(character:Character) -> Status:
	#var ship_velocity:Vector2 = Vector2(0.0, 1.0)
	#ship_velocity = ship_velocity.rotated(character.rotation) * character.ship_decceleration
	#character.velocity += ship_velocity
	#character.velocity = clampf(character.velocity.length(), 0.0, 100)
	
	#var ship_velocity:Vector2 = Vector2(0.0, -1.0)
	#ship_velocity = ship_velocity.rotated(character.rotation) * character.ship_decceleration
	#character.velocity -= ship_velocity
	
	character.velocity.move_toward(character.position, 1)
	
	return Status.DONE
