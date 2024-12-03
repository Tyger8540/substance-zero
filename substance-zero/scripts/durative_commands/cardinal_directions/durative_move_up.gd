# from exercise 1
class_name DurativeMoveUpCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration
	
	
func execute(character:Character) -> Status:
	character.velocity.y = -1 * character.speed
	character.rotation = character.UP_IN_RADIANS
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.y = 0
	return status
