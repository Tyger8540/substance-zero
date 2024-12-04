# from exercise 1
class_name DurativeMoveRightCommand
extends DurativeAnimationCommand

var _duration:float


func _init(duration:float):
	_duration = duration


func execute(character:Character) -> Status:
	character.velocity.x = character.character_speed
	character.facing = character.Facing.RIGHT
	for child in character.get_children():
		if child.name == "Sprite2D":
			child.flip_h = false
	var status:Command.Status = _manage_durative_animation_command(character, "move", _duration)
	if status == Status.DONE:
		character.velocity.x = 0
	return status
