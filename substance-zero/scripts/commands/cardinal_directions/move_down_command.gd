# modified from exercise 1
class_name MoveDownCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.x = 0
	var input = character.speed
	character.velocity.y = input
	#character.sprite.flip_h = false
	#character.change_facing(Character.Facing.DOWN)
	return Status.DONE
