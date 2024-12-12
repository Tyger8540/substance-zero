class_name RoomLimitedPowerUp
extends PowerUp

# @export var room_count: int = 0
var is_active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func updateRoomCount() -> void:
	uses -= 1
	if uses == 0:
		is_active = false


func enablePowerup(num_rooms: int) -> void:
	uses = num_rooms
	is_active = true
