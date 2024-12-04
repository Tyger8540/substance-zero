# modified from exercise 1
class_name MoveLeftCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.y = 0
	var input = -1 * character.character_speed
	character.velocity.x = input
	#character.sprite.flip_h = true
	#character.change_facing(Character.Facing.LEFT)
	character.facing = character.Facing.LEFT
	character.rotation = character.LEFT_IN_RADIANS
	return Status.DONE