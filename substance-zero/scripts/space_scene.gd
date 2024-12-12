class_name SpaceScene
extends Node2D

@export var asteroid:PackedScene

@onready var ship: Ship = $Ship

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
