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

# stats
const _DEFAULT_HEALTH:float = 100.0
const _DEFAULT_SPEED:float = 300.0
const _DEFAULT_LENGTH:float = 10.0
const _DEFAULT_DAMAGE:float = 10.0
@export var health:float = _DEFAULT_HEALTH
@export var speed:float = _DEFAULT_SPEED
@export var level:int = 0

@export var projectile_offset_x:float = 100.0

# inventory
var melee_weapon:Melee
var primary_weapon:int
var weapons:Array[Weapons]
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

# from exercise 1
var attacking:bool = false
var facing:Facing = Facing.RIGHT

# from exercise 3
@onready var projectile = load("res://scenes/weapons/projectile.tscn")
@onready var projectile_spawn = $"../ProjectileSpawn"

# from exercise 1
func take_damage(damage:float) -> void:
	health -= damage
	if health < 0.0:
		health = 0.0


func clear_weapons() -> void:
	#for weapon in weapons:
		# disable collision
		# make invisible
	for child in get_children():
		if child.name == "Melee":
			child.collision_layer = 0
			child.collision_mask = 0
	pass


func equip_melee(length:float=_DEFAULT_LENGTH, damage:float=_DEFAULT_DAMAGE) -> void:
	# clear other weapons
	for child in get_children():
		if child.name == "Melee":
			child.length = length
			child.damage = damage
			child.collision_layer = 8
			child.collision_mask = 0


func equip_primary(_length:float=_DEFAULT_LENGTH, _damage:float=_DEFAULT_DAMAGE) -> void:
	clear_weapons()
	primary_weapon = Weapons.LASER_GUN


func _ready():
	pass
	

func _physics_process(_delta):
	move_and_slide()
