extends Control


@onready var player: Player = $Player


func _ready() -> void:
	if player:
		player.unbind_player_input_commands()


func _on_start_button_pressed() -> void:
	# change scene to current level
	PlayerVariables.load_player_state(player)
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_options_button_pressed() -> void:
	# navigate to options menu
	get_tree().change_scene_to_file("res://scenes/UI/menus/options_menu.tscn")


func _on_level_select_button_pressed() -> void:
	# navigate to level select menu
	get_tree().change_scene_to_file("res://scenes/UI/menus/level_select_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_exit_button_pressed() -> void:
	# navigate to main menu
	get_tree().change_scene_to_file("res://scenes/UI/menus/start_menu.tscn")
