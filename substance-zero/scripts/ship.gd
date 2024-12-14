class_name Ship
extends Character

@onready var high_health = preload("res://sprites/environment/Spaceship/Main Ship/Main Ship - Bases/PNGs/Main Ship - Base - Full health.png")
@onready var medium_health = preload("res://sprites/environment/Spaceship/Main Ship/Main Ship - Bases/PNGs/Main Ship - Base - Slight damage.png")
@onready var low_health = preload("res://sprites/environment/Spaceship/Main Ship/Main Ship - Bases/PNGs/Main Ship - Base - Very damaged.png")
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_polygon_2d_2: CollisionPolygon2D = $HitBox/CollisionPolygon2D2

var _is_accelerating


func bind_ship_input_commands() -> void:
	rotate_left_command = RotateLeftCommand.new()
	rotate_right_command = RotateRightCommand.new()
	ship_accelerate_command = AccelerateCommand.new()
	ship_deccelerate_command = DeccelerateCommand.new()


func unbind_ship_input_commands() -> void:
	rotate_left_command = Command.new()
	rotate_right_command = Command.new()
	ship_accelerate_command = Command.new()
	ship_deccelerate_command = Command.new()


func _ready() -> void:
	health = 6
	bind_ship_input_commands()


func _physics_process(delta: float) -> void:
	#print(velocity.length())
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
	
	if health <= 2:
		sprite.texture = low_health
	elif health <= 4:
		sprite.texture = medium_health
	else:
		sprite.texture = high_health
	
	if health == 1:
		collision_polygon_2d_2.disabled = true
	
	super(delta)
