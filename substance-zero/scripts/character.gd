# modified from exercise 1
class_name Character
extends CharacterBody2D

enum Weapons {
	MELEE,
	LASER_GUN,
	PIERCING_GUN,
	ALL_DIRECTIONS_GUN
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
const UP_IN_RADIANS = 270 * 3.14 / 180.0
const DOWN_IN_RADIANS = 90 * 3.14 / 180.0

const _DEFAULT_HEALTH:float = 100.0
const _DEFAULT_SHIELD:float = 100.0
const _DEFAULT_CHARACTER_SPEED:float = 300.0
const _DEFAULT_CHARACTER_DASH:float = 1000.0
const _DEFAULT_SHIP_ACCELERATION:float = 6.0
const _DEFAULT_SHIP_DECCELERATION:float = 1.011
const _DEFAULT_ROTATE_SPEED:float = 0.04

const _DEFAULT_MELEE_LENGTH = 10.0
const _DEFAULT_MELEE_DAMAGE = 10.0
const _DEFAULT_MELEE_OFFSET = 55.0
const _DEFAULT_MELEE_DURATION = 0.5

const _DEFAULT_PROJECTILE_LENGTH = 10.0
const _DEFAULT_PROJECTILE_DAMAGE = 10.0
const _DEFAULT_PROJECTILE_SPEED = 20.0
const _DEFAULT_PROJECTILE_OFFSET = 50.0
const _DEFAULT_PROJECTILE_DURATION = 0.2

const _DEFAULT_PIERCING_PROJECTILE_LENGTH = 10.0
const _DEFAULT_PIERCING_PROJECTILE_DAMAGE = 10.0
const _DEFAULT_PIERCING_PROJECTILE_SPEED = 5.0
const _DEFAULT_PIERCING_PROJECTILE_OFFSET = 300.0
const _DEFAULT_PIERCING_PROJECTILE_DURATION = 5.0

# stats
@export var health:float = _DEFAULT_HEALTH
@export var shield:float = _DEFAULT_SHIELD
@export var total_health:float = _DEFAULT_HEALTH
@export var total_shield:float = _DEFAULT_SHIELD
@export var character_speed:float = _DEFAULT_CHARACTER_SPEED
@export var character_dash:float = _DEFAULT_CHARACTER_DASH
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

# projectiles
@export var default_piercing_projectile_length:float = _DEFAULT_PIERCING_PROJECTILE_LENGTH
@export var default_piercing_projectile_damage:float = _DEFAULT_PIERCING_PROJECTILE_DAMAGE
@export var default_piercing_projectile_speed:float = _DEFAULT_PIERCING_PROJECTILE_SPEED
@export var default_piercing_projectile_offset:float = _DEFAULT_PIERCING_PROJECTILE_OFFSET
@export var default_piercing_projectile_duration:float = _DEFAULT_PIERCING_PROJECTILE_DURATION

# inventory
var current_weapon:Weapons = Weapons.MELEE
var primary_weapon:Weapons = Weapons.ALL_DIRECTIONS_GUN
var power_ups:Array[PowerUp]

# commands from exercise 1 along with some new commands
var move_up_left:Command
var move_up_right:Command
var move_down_left:Command
var move_down_right:Command
var move_left:Command
var move_right:Command
var move_up:Command
var move_down:Command
# dash commands:
var dash_up_left:Command
var dash_up_right:Command
var dash_down_left:Command
var dash_down_right:Command
var dash_left:Command
var dash_right:Command
var dash_up:Command
var dash_down:Command

var attack:Command
var idle:Command
var rotate_left_command:Command
var rotate_right_command:Command
var ship_accelerate_command:Command
var ship_deccelerate_command:Command

var attacking:= false
var damaged := false
var dead := false

var char_name:String = ""

# from exercise 1
var facing:Facing = Facing.RIGHT

# from exercise 3
@onready var player_melee = load("res://scenes/weapons/player_melee.tscn")
@onready var player_projectile = load("res://scenes/weapons/player_projectile.tscn")
@onready var player_piercing_projectile = load("res://scenes/weapons/player_piercing_projectile.tscn")
@onready var enemy_melee = load("res://scenes/weapons/enemy_melee.tscn")
@onready var enemy_projectile = load("res://scenes/weapons/enemy_projectile.tscn")
@onready var enemy_piercing_projectile = load("res://scenes/weapons/enemy_piercing_projectile.tscn")

@onready var dialogue_box: DialogueBox = %DialogueBox

# from exercise 1
func take_damage(damage:float) -> void:
	health -= damage
	damaged = true
	if health <= 0.0:
		dead = true
		health = 0.0
		if name != "Player":
			queue_free()
			
		
		
func handle_position(hurtbox:HurtBox, offset:float) -> void:
	hurtbox.global_position = global_position
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


func attack_with_melee(length:float=default_melee_length, damage:float=default_melee_damage, offset:float=default_melee_offset, duration:float=default_melee_duration) -> void:
	
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
	var new_melee:Melee
	if char_name == "Player":
		new_melee = melee_factory.build_player_melee(melee_spec, self)
	elif char_name == "Enemy":
		new_melee = melee_factory.build_enemy_melee(melee_spec, self)
	
	# equip melee to character
	add_child(new_melee)
	
	# set position of melee
	handle_position(new_melee, offset)
	
	# handle direction
	set_facing_of_hurtbox(new_melee)
	
	
func fire_laser_gun(projectile_spawn:Node, length:float=default_projectile_length, damage:float=default_projectile_damage, speed:float=default_projectile_speed, offset:float=default_projectile_offset, duration:float=default_projectile_duration) -> void:
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
	handle_position(new_projectile, offset)
	
	# handle facing
	set_facing_of_hurtbox(new_projectile)
	
	
func fire_piercing_gun(projectile_spawn:Node, length:float=default_piercing_projectile_length, damage:float=default_piercing_projectile_damage, speed:float=default_piercing_projectile_speed, offset:float=default_piercing_projectile_offset, duration:float=default_piercing_projectile_duration) -> void:
	# modified from exercise 3
	
	# make a piercing projectile spec
	var piercing_projectile_spec:PiercingProjectileSpec = PiercingProjectileSpec.new()
	piercing_projectile_spec.length = length
	piercing_projectile_spec.damage = damage
	piercing_projectile_spec.speed = speed
	piercing_projectile_spec.offset = offset
	piercing_projectile_spec.duration = duration
	
	# make a piercing projectile factory to build the projectile
	var piercing_projectile_factory:PiercingProjectileFactory = PiercingProjectileFactory.new()
	
	# make a piercing projectile
	var new_piercing_projectile:PiercingProjectile = piercing_projectile_factory.build(piercing_projectile_spec, self)
	
	# add piercing projectile to projectile spawn
	projectile_spawn.add_child(new_piercing_projectile)
	
	# set position of piercing projectile
	handle_position(new_piercing_projectile, offset)
	
	# handle facing
	set_facing_of_hurtbox(new_piercing_projectile)
	
	
func fire_all_directions_gun(projectile_spawn:Node, length:float=default_projectile_length, damage:float=default_projectile_damage, speed:float=default_projectile_speed, offset:float=default_projectile_offset, duration:float=default_projectile_duration) -> void:
	# modified from exercise 3
	
	# save the character's facing when setting the offset for the projectiles
	var old_facing:Facing
	
	# make a projectile factory to build the projectile
	var projectile_factory:ProjectileFactory = ProjectileFactory.new()
	
	# make a new projectile
	var new_projectile:Projectile
	
	# make projectile specs
	var projectile_spec:ProjectileSpec
	for current_facing in range(len(Facing)):
		projectile_spec = ProjectileSpec.new()
		projectile_spec.length = length
		projectile_spec.damage = damage
		projectile_spec.speed = speed
		projectile_spec.offset = offset
		projectile_spec.duration = duration
		
		# make a new projectile
		new_projectile = projectile_factory.build(projectile_spec, self)
		
		# add projectile to projectile spawn
		projectile_spawn.add_child(new_projectile)
		
		# save the character's facing when setting the offset for the projectiles
		old_facing = facing
		# this is so handle position can correctly set the offset based on facing
		facing = current_facing
		
		# set position of projectile
		handle_position(new_projectile, offset)
		
		# handle facing
		set_facing_of_hurtbox(new_projectile)
		
		# set the character's facing back to the original
		facing = old_facing
		

func has_power_up(_type: Enums.Power_Up_Type) -> bool:
	for power_up in power_ups:
		if is_instance_valid(power_up) and power_up.type == _type:
			return true
	return false


func get_power_up(_type: Enums.Power_Up_Type) -> PowerUp:
	for power_up in power_ups:
		if is_instance_valid(power_up) and power_up.type == _type:
			return power_up
	return null


func _ready():
	pass


func _physics_process(_delta):
	move_and_slide()
	
