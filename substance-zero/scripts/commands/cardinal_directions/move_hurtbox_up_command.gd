# modified from exercise 1
class_name MoveHurtBoxUpCommand
extends HurtBoxCommand


func execute(hurtbox:HurtBox) -> void:
	hurtbox.global_position.y -= hurtbox.speed
