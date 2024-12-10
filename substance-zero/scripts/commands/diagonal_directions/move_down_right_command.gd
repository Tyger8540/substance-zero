# modified from exercise 1
class_name MoveDownRightCommand
extends Command


func execute(character: Character) -> Status:
	var input = (sqrt(2) / 2) * character.character_speed
	character.velocity.x = input
	character.velocity.y = input
	return Status.DONE
