# modified from exercise 1
class_name HurtBox
extends Area2D

enum Facing { 
	LEFT,
	RIGHT,
	UP,
	DOWN
}

# from exercise 1
var facing:Facing = Facing.RIGHT

# modified commmands from exercise 1
var move_right:HurtBoxCommand
var move_left:HurtBoxCommand
var move_up:HurtBoxCommand
var move_down:HurtBoxCommand


func _init() -> void:
	collision_layer = 8
	collision_mask = 0
	area_entered.connect(_on_area_entered)


func _on_area_entered(_hitbox:HitBox) -> void:
	return
