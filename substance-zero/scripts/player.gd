class_name Player
extends Character


# from exercise 1
func bind_player_input_commands() -> void:
	move_up_left = MoveUpLeftCommand.new()
	move_up_right = MoveUpRightCommand.new()
	move_down_left = MoveDownLeftCommand.new()
	move_down_right = MoveDownRightCommand.new()
	move_left = MoveLeftCommand.new()
	move_right = MoveRightCommand.new()
	move_up = MoveUpCommand.new()
	move_down = MoveDownCommand.new()
	attack = AttackCommand.new()
	idle = IdleCommand.new()


# from exercise 1
func unbind_player_input_commands() -> void:
	move_up_left = Command.new()
	move_up_right = Command.new()
	move_down_left = Command.new()
	move_down_right = Command.new()
	move_left = Command.new()
	move_right = Command.new()
	move_up = Command.new()
	move_down = Command.new()
	attack = Command.new()
	idle = Command.new()

# from exercise 1
func _ready():
	bind_player_input_commands()
	

# modified from exercise 1
# execute() commands are from exercise 1
func _physics_process(delta):
	
	# handle equipping weapons
	if Input.is_action_just_pressed("melee"):
		current_weapon = Weapons.MELEE
		print("equipped melee")
	elif Input.is_action_just_pressed("primary"):
		current_weapon = primary_weapon
		print("equipped primary weapon")
		
	if Input.is_action_just_pressed("attack"):
		attack.execute(self)
		
	# handle movement
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
		move_up_left.execute(self)
	elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
		move_up_right.execute(self)
	elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
		move_down_left.execute(self)
	elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
		move_down_right.execute(self)
	elif Input.is_action_pressed("move_left"):
		move_left.execute(self)
	elif Input.is_action_pressed("move_right"):
		move_right.execute(self)
	elif Input.is_action_pressed("move_up"):
		move_up.execute(self)
	elif Input.is_action_pressed("move_down"):
		move_down.execute(self)
	else:
		idle.execute(self)
		
	super(delta)
