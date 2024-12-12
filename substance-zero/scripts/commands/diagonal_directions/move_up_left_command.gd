# modified from exercise 1
class_name MoveUpLeftCommand
extends Command


func execute(character: Character) -> Status:
	var input = (sqrt(2) / 2) * character.character_speed
	character.velocity.x = -1 * input
	character.velocity.y = -1 * input
	return Status.DONE
