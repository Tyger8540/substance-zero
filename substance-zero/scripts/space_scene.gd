class_name SpaceScene
extends Node2D

@export var asteroid:PackedScene
<<<<<<< Updated upstream
=======
@export var duration:float = 15.0
@export var buffer:float = 100.0
@export var asteroid_spread:float = 10000.0
@export var num_asteroids:int = 2000
>>>>>>> Stashed changes

@onready var ship: Ship = $Ship
@onready var label: Label = $SpaceAutoscrollCamera/Label
@onready var space_autoscroll_camera: SpaceAutoscrollCamera = $SpaceAutoscrollCamera

<<<<<<< Updated upstream
var _num_asteroids:int = 100
var _asteroids:Array[Asteroid]


func _ready() -> void:
	for i in _num_asteroids:
		var ast = asteroid.instantiate() as Asteroid
		ast.global_position.x = ship.global_position.x + randf_range(-2000.0, 2000.0)
		ast.global_position.y = ship.global_position.y + randf_range(-2000.0, 2000.0)
		for other in _asteroids:
			if ast.global_position.length() - other.global_position.length() < 50:
				if randi_range(0, 1) == 1:
					ast.global_position.x += 75
					ast.global_position.y += 75
				else:
					ast.global_position.x -= 75
					ast.global_position.y -= 75
		_asteroids.push_back(ast)
		add_child(ast)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip_room"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
=======
var _asteroids:Array[Asteroid]
var _timer:Timer


func _ready() -> void:
	for i in num_asteroids:
		var ast = asteroid.instantiate() as Asteroid
		var quadrant = randi_range(0, 3)
		if quadrant == 0:
			ast.global_position.x = ship.global_position.x + randf_range(buffer, asteroid_spread)
			ast.global_position.y = ship.global_position.y + randf_range(buffer, asteroid_spread)
		elif quadrant == 1:
			ast.global_position.x = ship.global_position.x + randf_range(buffer, asteroid_spread)
			ast.global_position.y = ship.global_position.y + randf_range(-1 * buffer, -1 * asteroid_spread)
		elif quadrant == 2:
			ast.global_position.x = ship.global_position.x + randf_range(-1 * buffer, -1 * asteroid_spread)
			ast.global_position.y = ship.global_position.y + randf_range(-1 * buffer, -1 * asteroid_spread)
		else:
			ast.global_position.x = ship.global_position.x + randf_range(-1 * buffer, -1 * asteroid_spread)
			ast.global_position.y = ship.global_position.y + randf_range(buffer, asteroid_spread)
		for other in _asteroids:
			if ast.global_position.length() - other.global_position.length() < 50:
				if randi_range(0, 1) == 1:
					ast.global_position.x += buffer
					ast.global_position.y += buffer
				else:
					ast.global_position.x -= buffer
					ast.global_position.y -= buffer
		_asteroids.push_back(ast)
		add_child(ast)
		
	# from exercise 1
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	_timer.start(duration)
	
	label.text = "Pulling From Space momentarily"
	
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip_room"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Global.planet_number += 1
		
	# from exercise 3
	if _timer != null and _timer.is_stopped():
		_timer.queue_free()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Global.planet_number += 1
	
	if ship.health < 2:
		ship.unbind_ship_input_commands()
		label.text = "You sustained too much damage, were collecting scraps and will send you and the pieces down to next planet shortly"
	else:
		label.text = str("Pulling From Space in...", snapped(_timer.time_left, 0.1))
>>>>>>> Stashed changes
