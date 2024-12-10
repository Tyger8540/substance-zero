class_name CameraController
extends Node2D

@export var subject:CharacterBody2D


func _ready() -> void:
	global_position = subject.global_position
