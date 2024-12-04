# modified from exercise 1
class_name MoveDownCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.x = 0
	var input = character.character_speed
	character.velocity.y = input
	#character.sprite.flip_h = false
	character.facing = character.Facing.DOWN
	return Status.DONE
