# from exercise 1
class_name CutsceneTrigger
extends Area2D

#@export var camera_location:Node2D


func _on_body_entered(_body):
	# fix camera to camera_location and set position here
	
	$"../CutSceneManager".start_cutscene()
	queue_free()
