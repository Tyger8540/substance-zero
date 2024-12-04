# from exercise 1
class_name DurativeMoveRightCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration


func execute(character:Character) -> Status:
	character.velocity.x = character.character_speed
	character.facing = character.Facing.RIGHT
	character.rotation = character.RIGHT_IN_RADIANS
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.x = 0
	return status
