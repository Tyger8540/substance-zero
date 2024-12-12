class_name GrenadePowerUp
extends SingleUsePowerUp

var parent: Character
var facing: Character.Facing

var direction: Vector2
var initial_position: Vector2
var throw_distance: float = 300.0
var travel_distance: float = 0.0
var throw_speed: float = 200.0
var is_throwing: bool = false
var is_exploding: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("use_power_up") and not is_exploding and not is_throwing and uses > 0:
		use_power_up()
		animation_player.play("Moving")
	if is_throwing:
		if global_position == initial_position + direction * throw_distance:
			is_throwing = false
			# Explode
			animation_player.play("Explode")
			is_exploding = true
			pass
		else:
			global_position = global_position.move_toward(initial_position + direction * throw_distance, throw_speed * delta)
			# TODO
			# Account for grenade hitting walls, in which case the move_toward position should be right next to
			# the wall so it is always able to land
	if is_exploding and not animation_player.is_playing():
		is_exploding = false
		
func use_power_up() -> void:
	throw_grenade(parent.facing)
	
	super()


func throw_grenade(facing: Character.Facing) -> void:
	if facing == Character.Facing.LEFT:
		direction = Vector2(-1, 0)
	elif facing == Character.Facing.RIGHT:
		direction = Vector2(1, 0)
	elif facing == Character.Facing.UP:
		direction = Vector2(0, -1)
	elif facing == Character.Facing.DOWN:
		direction = Vector2(0, 1)
	top_level = true
	global_position = parent.global_position
	initial_position = global_position
	visible = true
	is_throwing = true
