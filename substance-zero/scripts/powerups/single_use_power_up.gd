class_name SingleUsePowerUp
extends PowerUp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# All single use power ups will have their own usage functionality then call super() for this function
func use_power_up() -> void:
	uses -= 1
	# Checks if that was the last use of the power up
	if uses == 0:
		# TODO
		# Remove power up from ability slot
		pass # remove this line
