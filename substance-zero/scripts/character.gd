# modified from exercise 1
class_name Character
extends CharacterBody2D

enum Weapons {
	MELEE,
	LASER_GUN,
	PIERCING_GUN
}

enum Facing { 
	LEFT,
	RIGHT,
	UP,
	DOWN
}

# constants
const LEFT_IN_RADIANS = 180.0 * 3.14 / 180.0
const RIGHT_IN_RADIANS = 0.0 * 3.14 / 180.0
const UP_IN_RADIANS = 90 * 3.14 / 180.0
const DOWN_IN_RADIANS = 270 * 3.14 / 180.0

const _DEFAULT_HEALTH:float = 100.0
const _DEFAULT_CHARACTER_SPEED:float = 300.0
const _DEFAULT_SHIP_ACCELERATION:float = 6.0
const _DEFAULT_SHIP_DECCELERATION:float = 2.0
const _DEFAULT_ROTATE_SPEED:float = 0.04

const _DEFAULT_MELEE_LENGTH = 10.0
const _DEFAULT_MELEE_DAMAGE = 10.0
const _DEFAULT_MELEE_OFFSET = 120.0
const _DEFAULT_MELEE_DURATION = 0.5

const _DEFAULT_PROJECTILE_LENGTH = 10.0
const _DEFAULT_PROJECTILE_DAMAGE = 10.0
const _DEFAULT_PROJECTILE_SPEED = 50.0
const _DEFAULT_PROJECTILE_OFFSET = 120.0
const _DEFAULT_PROJECTILE_DURATION = 0.2

# stats
@export var health:float = _DEFAULT_HEALTH
@export var character_speed:float = _DEFAULT_CHARACTER_SPEED
@export var ship_acceleration:float = _DEFAULT_SHIP_ACCELERATION
@export var ship_decceleration:float = _DEFAULT_SHIP_DECCELERATION
@export var level:int = 0
@export var ship_rotate_speed:float = _DEFAULT_ROTATE_SPEED

# melee
@export var default_melee_length:float = _DEFAULT_MELEE_LENGTH
@export var default_melee_damage:float = _DEFAULT_MELEE_DAMAGE
@export var default_melee_offset:float = _DEFAULT_MELEE_OFFSET
@export var default_melee_duration:float = _DEFAULT_MELEE_DURATION

# projectiles
@export var default_projectile_length:float = _DEFAULT_PROJECTILE_LENGTH
@export var default_projectile_damage:float = _DEFAULT_PROJECTILE_DAMAGE
@export var default_projectile_speed:float = _DEFAULT_PROJECTILE_SPEED
@export var default_projectile_offset:float = _DEFAULT_PROJECTILE_OFFSET
@export var default_projectile_duration:float = _DEFAULT_PROJECTILE_DURATION

# inventory
var current_weapon:Weapons = Weapons.MELEE
var primary_weapon:Weapons = Weapons.LASER_GUN
var powerups:Array[int]

# commands from exercise 1 along with some new commands
var move_up_left:Command
var move_up_right:Command
var move_down_left:Command
var move_down_right:Command
var move_left:Command
var move_right:Command
var move_up:Command
var move_down:Command
var attack:Command
var idle:Command
var rotate_left_command:Command
var rotate_right_command:Command
var ship_accelerate_command:Command
var ship_deccelerate_command:Command

var attacking:= false
var damaged := false
var dead := false

# from exercise 1
var facing:Facing = Facing.RIGHT

# from exercise 3
@onready var melee = load("res://scenes/weapons/melee.tscn")
@onready var projectile = load("res://scenes/weapons/projectile.tscn")

# from exercise 1
func take_damage(damage:float) -> void:
	health -= damage
	damaged = true
	if health <= 0.0:
		dead = true
		health = 0.0
		queue_free()
		print("character died")
		
		
func handle_position(hurtbox:HurtBox, starting_position_x:float, starting_position_y:float, offset:float) -> void:
	hurtbox.global_position.x = starting_position_x
	hurtbox.global_position.y = starting_position_y
	if facing == Facing.LEFT:
		hurtbox.global_position.x -= offset
	elif facing == Facing.RIGHT:
		hurtbox.global_position.x += offset
	elif facing == Facing.UP:
		hurtbox.global_position.y -= offset
	elif facing == Facing.DOWN:
		hurtbox.global_position.y += offset
		
		
func set_facing_of_hurtbox(hurtbox:HurtBox) -> void:
	if facing == Facing.LEFT:
		hurtbox.rotation = LEFT_IN_RADIANS
		hurtbox.facing = hurtbox.Facing.LEFT
	elif facing == Facing.RIGHT:
		hurtbox.rotation = RIGHT_IN_RADIANS
		hurtbox.facing = hurtbox.Facing.RIGHT
	elif facing == Facing.UP:
		hurtbox.rotation = UP_IN_RADIANS
		hurtbox.facing = hurtbox.Facing.UP
	elif facing == Facing.DOWN:
		hurtbox.rotation = DOWN_IN_RADIANS
		hurtbox.facing = hurtbox.Facing.DOWN


func attack_with_melee(starting_position_x:float=global_position.x, starting_position_y:float=global_position.y, length:float=default_melee_length, damage:float=default_melee_damage, offset:float=default_melee_offset, duration:float=default_melee_duration) -> void:
	
	# check if player already has melee equipped
	for child in get_children():
		if child.name == "Melee":
			return
	
	# modified from exercise 3
	
	# make a melee spec
	var melee_spec:MeleeSpec = MeleeSpec.new()
	melee_spec.length = length
	melee_spec.damage = damage
	# duration makes the melee disappear so it does not block projectiles
	melee_spec.duration = duration
	melee_spec.offset = offset
	
	# make a melee factory to build the melee
	var melee_factory:MeleeFactory = MeleeFactory.new()
	
	# make a melee
	var new_melee:Melee = melee_factory.build(melee_spec, self)
	
	# equip melee to character
	add_child(new_melee)
	
	# set position of melee
	handle_position(new_melee, starting_position_x, starting_position_y, offset)
	
	# handle direction
	set_facing_of_hurtbox(new_melee)
	
	
func fire_laser_gun(projectile_spawn:Node, starting_position_x:float=global_position.x, starting_position_y:float=global_position.y, length:float=default_projectile_length, damage:float=default_projectile_damage, speed:float=default_projectile_speed, offset:float=default_projectile_offset, duration:float=default_projectile_duration) -> void:
	
	# modified from exercise 3
	
	# make a projectile spec
	var projectile_spec:ProjectileSpec = ProjectileSpec.new()
	projectile_spec.length = length
	projectile_spec.damage = damage
	projectile_spec.speed = speed
	projectile_spec.offset = offset
	projectile_spec.duration = duration
	
	# make a projectile factory to build the projectile
	var projectile_factory:ProjectileFactory = ProjectileFactory.new()
	
	# make a projectile
	var new_projectile:Projectile = projectile_factory.build(projectile_spec, self)
	
	# add projectile to projectile spawn
	projectile_spawn.add_child(new_projectile)
	
	# set position of projectile
	handle_position(new_projectile, starting_position_x, starting_position_y, offset)
	
	# handle facing
	set_facing_of_hurtbox(new_projectile)


func _ready():
	pass


func _physics_process(_delta):
	move_and_slide()
