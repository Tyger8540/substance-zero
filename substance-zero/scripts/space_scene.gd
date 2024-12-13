class_name SpaceScene
extends Node2D

@export var asteroid:PackedScene
@export var duration:float = 15.0

@onready var ship: Ship = $Ship

var _num_asteroids:int = 10
var _timer:Timer


func _ready() -> void:
	var asteroids:Array[Asteroid]
	for i in _num_asteroids:
		var ast = asteroid.instantiate() as Asteroid
		ast.global_position.x = ship.global_position.x + randf_range(50, 500)
		ast.global_position.y = ship.global_position.y + randf_range(50, 500)
		asteroids.push_back(ast)
		add_child(ast)
		
	# from exercise 1
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	_timer.start(duration)
	
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip_room"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
	# from exercise 3
	if _timer != null and _timer.is_stopped():
		_timer.queue_free()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
		
