extends Node
class_name SoundQueue 

var _audioStreamPlayers = []
@export var count = 1 
var _next = 0
func _ready() -> void: 
	if get_child_count() == 0: 
		print("No audio stream player found")
		return 
	
	var child = get_child(0)
	if child is AudioStreamPlayer2D: 
		_audioStreamPlayers.append(child)
		for i in range(count): 
			var dup = child.duplicate() as AudioStreamPlayer2D
			add_child(dup)
			_audioStreamPlayers.append(dup)


func playSound(): 
	if !_audioStreamPlayers[_next].playing:
		_audioStreamPlayers[_next].play()
		_next += 1
		_next = _next % _audioStreamPlayers.size() 
func stopSound(): 
	for child in _audioStreamPlayers: 
		child.stop()
