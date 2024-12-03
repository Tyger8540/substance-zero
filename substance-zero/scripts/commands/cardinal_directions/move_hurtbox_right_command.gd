# modified from exercise 1
class_name MoveHurtBoxRightCommand
extends HurtBoxCommand


func execute(hurtbox:HurtBox) -> void:
	hurtbox.global_position.x += hurtbox.speed
