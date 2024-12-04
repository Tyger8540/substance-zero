# modified from exercise 1
class_name MoveRightCommand
extends Command


func execute(character: Character) -> Status:
	character.velocity.y = 0
	var input = character.character_speed
	character.velocity.x = input
	#character.sprite.flip_h = false
	#character.change_facing(Character.Facing.RIGHT)
	character.facing = character.Facing.RIGHT
	for child in character.get_children():
		if child.name == "Sprite2D":
			child.flip_h = false
	return Status.DONE
