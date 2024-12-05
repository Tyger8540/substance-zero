extends Control


@onready var player: Player = $Player
@onready var pause_menu: Control = $"."

var paused: bool = true


func _ready() -> void:
	if player:
		player.unbind_player_input_commands()
		
		
func process() -> void:
	# check for pause input (esc)
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()


func _on_start_button_pressed() -> void:
	# change scene to current level
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_options_button_pressed() -> void:
	# navigate to options menu
	pass


func _on_level_select_button_pressed() -> void:
	# navigate to level select menu
	get_tree().change_scene_to_file("res://scenes/UI/level_select_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_exit_button_pressed() -> void:
	# navigate to main menu
	get_tree().change_scene_to_file("res://scenes/UI/start_menu.tscn")


func _toggle_pause() -> void:
	print("paused")
	if paused:
		pause_menu.hide()
		paused = false
		get_tree().paused = false
	else:
		pause_menu.show()
		paused = true
		get_tree().paused = true
	
