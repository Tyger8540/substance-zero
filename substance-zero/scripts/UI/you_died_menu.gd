class_name YouDiedMenu
extends Control


@onready var player: Player = get_node("../../../Player")


func _ready() -> void:
	Signals.player_death.connect(_on_player_death)
	
	
func _process(delta) -> void:
	# check for pause input (esc)
	if player.dead or Input.is_action_just_pressed("kill_player"):
		player.deaths += 1
		self.show()
		get_tree().paused = true
		
	
func _on_home_button_pressed() -> void:
	# navigate to main menu
	get_tree().paused = false
	PlayerVariables.save_player_state(player)
	get_tree().change_scene_to_file("res://scenes/UI/menus/start_menu.tscn")


func _on_player_death() -> void:
	player.deaths += 1
	self.show()
	get_tree().paused = true
