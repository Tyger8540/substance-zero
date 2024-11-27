class_name Character
extends CharacterBody2D

enum Weapons {
	MELEE,
	LASER_GUN,
	CHARGE_GUN
}

enum Facing { 
	LEFT,
	RIGHT,
	UP,
	DOWN
}

const _DEFAULT_HEALTH = 100.0
const _DEFAULT_SPEED = 300.0
@export var health:float = _DEFAULT_HEALTH
@export var speed:float = _DEFAULT_SPEED
@export var level:int = 0
var weapon:int = Weapons.MELEE
var powerups:Array[int]

# commands
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


func _ready():
	pass
	

func _physics_process(_delta):
	move_and_slide()
