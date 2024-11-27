class_name DurativeMoveUpCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration
	
	
func execute(character:Character) -> Status:
	character.velocity.y = -1 * character.speed
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.y = 0
	return status
