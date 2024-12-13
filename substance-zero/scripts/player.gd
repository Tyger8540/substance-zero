class_name Player
extends Character

const _SPAWN_OFFSET = 50.0
const EXPLODING_DASH_POWER_UP = preload("res://scenes/power_ups/exploding_dash_power_up.tscn")

var credits:int = 500
var deaths:int = 0

var _dash_timer:Timer
var _dash_cooldown:Timer

var spawned:bool = false

@onready var animation_tree: AnimationTree = $AnimationTree
# from exercise 3
@onready var projectile_spawn = $"../ProjectileSpawn"
@onready var PlayerSound = $PlayerSoundManager

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
	# dash bindings:
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
	dead = false
	animation_tree.active = true
	bind_player_input_commands()
	#var power_up = EXPLODING_DASH_POWER_UP.instantiate()
	#add_child(power_up)
	#PlayerVariables.power_ups.append(power_up)
	char_name = "NOVA"


# modified from exercise 1
# execute() commands are from exercise 1
func _physics_process(delta):
	
	if not spawned and Global.rooms_spawned:
		global_position.x = Global.room_position_array[len(Global.room_position_array) - 1].x + _SPAWN_OFFSET
		global_position.y = Global.room_position_array[len(Global.room_position_array) - 1].y + _SPAWN_OFFSET
		spawned = true
		print("spawned")
		
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
			
			var dashed: bool = false
			
			if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
				dash_up_left.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
				dash_up_right.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
				dash_down_left.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
				dash_down_right.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_up"):
				dash_up.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_down"):
				dash_down.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_left"):
				dash_left.execute(self)
				dashed = true
			elif Input.is_action_pressed("move_right"):
				dash_right.execute(self)
				dashed = true
			
			# NOTE
			# Implementation for the exploding dash power up
			if PlayerVariables.has_power_up(Enums.Power_Up_Type.EXPLODING_DASH) and dashed:
				$ExplodingDashPowerUp.start_spawning()
				
			if dashed: 
				PlayerSound.get_node("dash").playSound()
	super(delta)
	
	_manage_animation_tree_state()


func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x) || !is_zero_approx(velocity.y):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/moving"] = true
		PlayerSound.get_node("./running").playSound()
	else:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/moving"] = false
		PlayerSound.get_node("./running").stopSound()
	#toggles
	if attacking:
		if current_weapon == Weapons.MELEE:
			animation_tree["parameters/conditions/attacking"] = true
			animation_tree["parameters/conditions/gun_attacking"] = false
			attacking = false
			PlayerSound.get_node("./sword").playSound()
			
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
