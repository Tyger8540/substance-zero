extends Control


@onready var player: Player = get_node("../Player")

		
func _process(delta) -> void:
	# check for pause input (esc)
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()
	

func _on_exit_button_pressed() -> void:
	# navigate to main menu
	get_tree().paused = false
	PlayerVariables.save_player_state(player)
	get_tree().change_scene_to_file("res://scenes/UI/start_menu.tscn")


func _toggle_pause() -> void:
	if get_tree().paused:
		self.hide()
		get_tree().paused = false
	else:
		self.show()
		get_tree().paused = true
	
