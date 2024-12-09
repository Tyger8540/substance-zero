class_name DashDownCommand
extends Command


func execute(character:Character) -> Status:
	var input = character.character_dash
	character.velocity.y += input
	
	return Status.DONE
