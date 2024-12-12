# modified from exercise 1
class_name MoveHurtBoxLeftCommand
extends HurtBoxCommand


func execute(hurtbox:HurtBox, speed:float) -> void:
	hurtbox.global_position.x -= speed
