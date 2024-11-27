class_name MoveDownLeftCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.speed
	character.velocity.x = -1 * input
	character.velocity.y = input
	return Status.DONE
