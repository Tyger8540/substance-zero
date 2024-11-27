class_name MoveUpCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.x = 0
	var input = -1 * character.speed
	character.velocity.y = input
	#character.sprite.flip_h = true
	#character.change_facing(Character.Facing.UP)
	return Status.DONE
