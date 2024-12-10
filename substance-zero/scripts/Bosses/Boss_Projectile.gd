class_name BossProjectile
extends Projectile

var direction:Vector2
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	super()
	var angle = direction.angle()
	sprite_2d.rotation = angle
	

func _physics_process(_delta):
	# fire projectile in the direction that the character is facing
	move_left.execute(self, direction.x * speed)
	move_down.execute(self, -direction.y * speed)
	
	# from exercise 3
	if _timer != null and _timer.is_stopped():
		_timer.queue_free()
		queue_free()
