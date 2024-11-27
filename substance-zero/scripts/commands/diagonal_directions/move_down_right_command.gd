# modified from exercise 1
class_name MoveDownRightCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.speed
	character.velocity.x = input
	character.velocity.y = input
	return Status.DONE
