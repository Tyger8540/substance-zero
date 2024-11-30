# modified from exercise 1
class_name HurtBox
extends Area2D

enum Facing { 
	LEFT,
	RIGHT,
	UP,
	DOWN
}

var facing:Facing = Facing.RIGHT

# commmands
var move_right:HurtBoxCommand
var move_left:HurtBoxCommand
var move_up:HurtBoxCommand
var move_down:HurtBoxCommand

# stats
var length:float
var damage:float
var speed:float = 50.0


func _init() -> void:
	collision_layer = 8
	collision_mask = 0
	area_entered.connect(_on_area_entered)


func _on_area_entered(_hitbox:HitBox) -> void:
	return
