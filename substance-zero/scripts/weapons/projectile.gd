# modified from exercise 1
class_name Projectile
extends HurtBox

const name_of_hurtbox:String = "Projectile"

# stats
@export var length:float
@export var damage:float
@export var speed:float
@export var offset:float
@export var duration:float

var _timer:Timer


func bind_commands() -> void:
	move_left = MoveHurtBoxLeftCommand.new()
	move_right = MoveHurtBoxRightCommand.new()
	move_up = MoveHurtBoxUpCommand.new()
	move_down = MoveHurtBoxDownCommand.new()


func _ready():
	# from exercise 1
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	_timer.start(duration)
	bind_commands()
	
	$laser.playSound()


func _physics_process(_delta):
	# fire projectile in the direction that the character is facing
	if facing == Facing.LEFT:
		move_left.execute(self, speed)
	elif facing == Facing.RIGHT:
		move_right.execute(self, speed)
	elif facing == Facing.UP:
		move_up.execute(self, speed)
	elif facing == Facing.DOWN:
		move_down.execute(self, speed)
	
	# from exercise 3
	if _timer != null and _timer.is_stopped():
		_timer.queue_free()
		queue_free()
	
