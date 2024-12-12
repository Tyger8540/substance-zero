class_name AccelerateCommand
extends Command


func execute(character: Character) -> Status:
	var ship_velocity:Vector2 = Vector2(0.0, -1.0)
	ship_velocity = ship_velocity.rotated(character.rotation) * character.ship_acceleration
	character.velocity += ship_velocity
	character.velocity.x = clampf(character.velocity.x, -2000.0, 2000.0)
	character.velocity.y = clampf(character.velocity.y, -2000.0, 2000.0)
	return Status.DONE
