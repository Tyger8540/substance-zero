# modified from exercise 1
class_name Melee
extends HurtBox

@export var length:float
@export var damage:float
@export var duration:float
@export var offset:float
var _timer:Timer


func _ready():
	# do something with length here
	# from exercise 1
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	_timer.start(duration)
	

func _physics_process(_delta):
	# from exercise 3
	if _timer != null and _timer.is_stopped():
		_timer.queue_free()
		queue_free()
