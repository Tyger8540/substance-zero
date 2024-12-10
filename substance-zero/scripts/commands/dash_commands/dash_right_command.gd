class_name DashRightCommand
extends Command


func execute(character:Character) -> Status:
	var input = character.character_dash
	character.velocity.x += input
	
	return Status.DONE
