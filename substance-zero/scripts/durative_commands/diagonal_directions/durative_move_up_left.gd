# modified from exercise 1
class_name DurativeMoveUpLeftCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration
	
	
func execute(character:Character) -> Status:
	character.velocity.x = -1 * character.character_speed
	character.velocity.y = -1 * character.character_speed
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.x = 0
		character.velocity.y = 0
	return status
