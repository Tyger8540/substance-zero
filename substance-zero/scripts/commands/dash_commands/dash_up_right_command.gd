class_name DashUpRightCommand
extends Command


func execute(character:Character) -> Status:
	var input = (sqrt(2) / 2) * character.character_dash
	character.velocity.x += input
	character.velocity.y -= input
	
	return Status.DONE
