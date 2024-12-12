class_name RotateRightCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.ship_rotate_speed
	character.rotation += input
	return Status.DONE
