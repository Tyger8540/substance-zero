# modified from exercise 1
class_name MoveHurtBoxDownCommand
extends HurtBoxCommand


func execute(hurtbox:HurtBox) -> void:
	hurtbox.global_position.y += hurtbox.speed
