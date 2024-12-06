class_name Ship
extends Character


func bind_ship_input_commands() -> void:
	rotate_left_command = RotateLeftCommand.new()
	rotate_right_command = RotateRightCommand.new()


func _ready() -> void:
	bind_ship_input_commands()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		rotate_left_command.execute(self)
	if Input.is_action_pressed("move_right"):
		rotate_right_command.execute(self)
