# from excise 1

class_name DurativeDialogueCommand
extends DurativeAnimationCommand

var _script:String = ""
var _duration:float

func _init(script:String, duration:float = 1.0):
	_script = script
	_duration = duration
	
func execute(character:Character) -> Command.Status:
	print(_timer)
	if _timer == null:
		character.dialogue_box.dialogue.text = _script
		character.dialogue_box.character_name.text = character.char_name
		character.dialogue_box.visible = true
		_timer = Timer.new()
		character.add_child(_timer)
		_timer.one_shot = true
		_timer.start(_duration)
		return Status.ACTIVE
	
	if (Input.is_action_just_pressed("start_cutscene")):
		print("stop")
		_timer.stop()
	
	if !_timer.is_stopped():
		print("IS NOT STOPPED")
		return Status.ACTIVE
	else:
		#print("IS STOPPED")
		character.dialogue_box.visible = false
		return Status.DONE
