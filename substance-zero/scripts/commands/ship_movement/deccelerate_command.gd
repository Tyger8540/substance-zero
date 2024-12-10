class_name DeccelerateCommand
extends Command

# TODO need to make work
func execute(character:Character) -> Status:
	if character.velocity.length() > 0:
		character.velocity /= character.ship_decceleration
	if character.velocity.length() < 12:
		character.velocity = Vector2(0.0, 0.0)
	return Status.DONE
