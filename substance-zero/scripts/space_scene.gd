class_name SpaceScene
extends Node2D

@export var asteroid:PackedScene

@onready var ship: Ship = $Ship

var _num_asteroids:int = 10


func _ready() -> void:
	var asteroids:Array[Asteroid]
	for i in _num_asteroids:
		var ast = asteroid.instantiate() as Asteroid
		ast.global_position.x = ship.global_position.x + randf_range(50, 500)
		ast.global_position.y = ship.global_position.y + randf_range(50, 500)
		asteroids.push_back(ast)
		add_child(ast)
	$SpaceDemoTimer.start()


func _on_space_demo_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
