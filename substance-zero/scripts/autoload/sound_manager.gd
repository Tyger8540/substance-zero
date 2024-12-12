extends Node


func playSound(sname: String): 
	for child in get_children(): 
		if(child.name == sname): 
			child.playSound()

func stopSound(sname:String): 
	for child in get_children(): 
		if(child.name == sname): 
			child.stopSound()
