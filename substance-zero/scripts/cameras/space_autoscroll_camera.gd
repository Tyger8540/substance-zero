class_name SpaceAutoscrollCamera
extends CameraController

@export var scroll_speed:float
@export var max_lead:float

var _verticle_boundary_distance:float = 324

func _ready() -> void:
	super()


func _process(delta: float) -> void:
	global_position.x += scroll_speed
	
	var trail_distance = global_position.x - subject.global_position.x
	if trail_distance > max_lead:
		if subject.velocity.x < 0:
			subject.velocity.x = 0
		subject.global_position.x += trail_distance - max_lead
	
	var lead_distance = subject.global_position.x - global_position.x
	if lead_distance > max_lead:
		if subject.velocity.x > 0:
			subject.velocity.x = 0
		subject.global_position.x -= lead_distance - max_lead
	
	var verticle_distance = global_position.y - subject.global_position.y
	if abs(verticle_distance) > _verticle_boundary_distance:
		if verticle_distance > 0:
			subject.global_position.y += 648
		else:
			subject.global_position.y -= 648
