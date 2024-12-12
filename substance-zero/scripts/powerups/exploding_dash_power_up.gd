class_name ExplodingDashPowerUp
extends RoomLimitedPowerUp

const GRENADE_POWER_UP_SCENE = preload("res://scenes/power_ups/grenade_power_up.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_grenade() -> void:
	var grenade = GRENADE_POWER_UP_SCENE.instantiate()
	add_child(grenade)
	grenade.make_visible()
	grenade.explode()
	$ExplosionTimer1.start()


func _on_explosion_timer_1_timeout() -> void:
	for child in get_children():
		if child is GrenadePowerUp:
			child.queue_free()
