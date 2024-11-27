# modified from exercise 1
class_name MoveUpRightCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.speed
	character.velocity.x = input
	character.velocity.y = -1 * input
	return Status.DONE
