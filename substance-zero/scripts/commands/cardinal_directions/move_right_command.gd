class_name MoveRightCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.y = 0
	var input = character.speed
	character.velocity.x = input
	#character.sprite.flip_h = false
	#character.change_facing(Character.Facing.RIGHT)
	return Status.DONE
