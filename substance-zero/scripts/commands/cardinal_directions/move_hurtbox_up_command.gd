# modified from exercise 1
class_name MoveHurtBoxUpCommand
extends HurtBoxCommand


func execute(hurtbox:HurtBox, speed:float) -> void:
	hurtbox.global_position.y -= speed
