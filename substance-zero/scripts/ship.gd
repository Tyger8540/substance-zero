class_name Ship
extends Character

var _is_accelerating


func bind_ship_input_commands() -> void:
	rotate_left_command = RotateLeftCommand.new()
	rotate_right_command = RotateRightCommand.new()
	ship_accelerate_command = AccelerateCommand.new()
	ship_deccelerate_command = DeccelerateCommand.new()


func _ready() -> void:
	bind_ship_input_commands()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		rotate_left_command.execute(self)
	if Input.is_action_pressed("move_right"):
		rotate_right_command.execute(self)
	if Input.is_action_pressed("move_up"):
		ship_accelerate_command.execute(self)
		_is_accelerating = true
	if Input.is_action_just_released("move_up"):
		_is_accelerating = false
	if not _is_accelerating:
		ship_deccelerate_command.execute(self)
	
	super(delta)
