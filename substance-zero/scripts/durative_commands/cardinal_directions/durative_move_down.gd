# from exercise 1
class_name DurativeMoveDownCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration
	
	
func execute(character:Character) -> Status:
	character.velocity.y = character.speed
	character.rotation = character.DOWN_IN_RADIANS
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.y = 0
	return status
