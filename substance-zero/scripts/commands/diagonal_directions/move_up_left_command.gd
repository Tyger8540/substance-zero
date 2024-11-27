class_name MoveUpLeftCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.speed
	character.velocity.x = -1 * input
	character.velocity.y = -1 * input
	return Status.DONE
