class_name GrenadePowerUp
extends SingleUsePowerUp

var parent: Character
var facing: Character.Facing

var direction: Vector2
var initial_position: Vector2
var throw_distance: float = 300.0
var travel_distance: float = 0.0
var throw_speed: float = 500.0
var is_throwing: bool = false
var is_exploding: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent() is Character and get_parent().has_power_up(Enums.Power_Up_Type.GRENADE) and uses == 0:
		uses = get_parent().get_power_up(Enums.Power_Up_Type.GRENADE).uses
	if Input.is_action_just_pressed("use_grenade") and not is_exploding and not is_throwing and uses > 0 and get_parent() is Character:
		use_power_up()
		animation_player.play("Moving")
	if is_throwing:
		if global_position == initial_position + direction * throw_distance:
			is_throwing = false
			# Explode
			explode()
		else:
			global_position = global_position.move_toward(initial_position + direction * throw_distance, throw_speed * delta)
			# TODO
			# Account for grenade hitting walls, in which case the move_toward position should be right next to
			# the wall so it is always able to land
	if is_exploding and not animation_player.is_playing():
		is_exploding = false

func use_power_up() -> void:
	throw_grenade(get_parent().facing)
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
	make_visible()
	is_throwing = true


func make_visible() -> void:
	top_level = true
	#print()
	#print("global pos")
	#print(%Player.global_position)
	global_position = get_parent().global_position
	initial_position = global_position
	visible = true
	print()
	print("global pos")
	print(global_position)


func explode() -> void:
	animation_player.play("Explode")
	is_exploding = true
