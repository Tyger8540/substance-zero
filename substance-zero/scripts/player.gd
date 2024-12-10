class_name Player
extends Character

@onready var animation_tree: AnimationTree = $AnimationTree
# from exercise 3
@onready var projectile_spawn = $"../ProjectileSpawn"

var credits:int = 200

var _dash_timer:Timer
var _dash_cooldown:Timer

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
	#dash bindings:
	dash_up_left = DashUpLeftCommand.new()
	dash_up_right = DashUpRightCommand.new()
	dash_down_left = DashDownLeftCommand.new()
	dash_down_right = DashDownRightCommand.new()
	dash_left = DashLeftCommand.new()
	dash_right = DashRightCommand.new()
	dash_up = DashUpCommand.new()
	dash_down = DashDownCommand.new()
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
	animation_tree.active = true
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
	# This first if statement is to prevent movement during the dash
	if _dash_timer == null or _dash_timer.is_stopped():
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
	
	# handle dashing
	# The initial if statement to to make sure the dash cooldown has ended before allowing more dashes
	# NOTE: could be a little too similar to Hades but I could also implement a check if two dashes becomes a powerup - Alex
	if _dash_cooldown == null or _dash_cooldown.is_stopped():
		if Input.is_action_just_pressed("dash"):
			# Timer to make sure player cannot move during dash (AKA cannot move for the 0.08 seconds the dash takes
			# NOTE: This time limit could(probably should)be turned into a variable to allow for different dash timings. As a powerup?? - Alex
			_dash_timer = Timer.new()
			_dash_timer.one_shot = true
			add_child(_dash_timer)
			_dash_timer.start(0.08)
			
			#Dash cooldown Timer
			# NOTE: Time limit could also be altered by powerups, I could implement a variable instead of a number - Alex
			_dash_cooldown = Timer.new()
			_dash_cooldown.one_shot = true
			add_child(_dash_cooldown)
			_dash_cooldown.start(0.33)
			
			if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
				dash_up_left.execute(self)
			elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
				dash_up_right.execute(self)
			elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
				dash_down_left.execute(self)
			elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
				dash_down_right.execute(self)
			elif Input.is_action_pressed("move_up"):
				dash_up.execute(self)
			elif Input.is_action_pressed("move_down"):
				dash_down.execute(self)
			elif Input.is_action_pressed("move_left"):
				dash_left.execute(self)
			elif Input.is_action_pressed("move_right"):
				dash_right.execute(self)
	
	super(delta)
	
	_manage_animation_tree_state()


func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/moving"] = true
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/moving"] = false
	#toggles
	if attacking:
		if current_weapon == Weapons.MELEE:
			animation_tree["parameters/conditions/attacking"] = true
			animation_tree["parameters/conditions/gun_attacking"] = false
			attacking = false
		elif current_weapon == Weapons.LASER_GUN:
			animation_tree["parameters/conditions/gun_attacking"] = true
			animation_tree["parameters/conditions/attacking"] = false
			attacking = false
	else:
		animation_tree["parameters/conditions/attacking"] = false
		animation_tree["parameters/conditions/gun_attacking"] = false
		
	if damaged:
		animation_tree["parameters/conditions/damaged"] = true
		damaged = false
	else:
		animation_tree["parameters/conditions/damaged"] = false
