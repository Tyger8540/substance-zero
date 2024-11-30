# modified from exercise 1
class_name Projectile
extends HurtBox


func bind_commands() -> void:
	#move_left = MoveHurtBoxLeftCommand.new()
	move_right = MoveHurtBoxRightCommand.new()
	#move_up = MoveHurtBoxUpCommand.new()
	#move_down = MoveHurtBoxDownCommand.new()


func _ready():
	bind_commands()


func _physics_process(_delta):
	# fire projectile in the direction that the character is facing
	#if facing == Facing.LEFT:
		#move_left.execute(self)
	#elif facing == Facing.RIGHT:
		#move_right.execute(self)
	#elif facing == Facing.UP:
		#move_up.execute(self)
	#elif facing == Facing.DOWN:
		#move_down.execute(self)
		
	if facing == Facing.RIGHT:
		move_right.execute(self)
	
