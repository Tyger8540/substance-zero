# modified from exercise 1
class_name MoveUpCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.x = 0
	var input = -1 * character.speed
	character.velocity.y = input
	#character.sprite.flip_h = true
	#character.change_facing(Character.Facing.UP)
	character.facing = character.Facing.UP
	character.rotation = character.UP_IN_RADIANS
	return Status.DONE
