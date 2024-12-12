class_name ExplodingDashPowerUp
extends RoomLimitedPowerUp

const GRENADE_POWER_UP_SCENE = preload("res://scenes/power_ups/grenade_power_up.tscn")
@export var num_grenades: int = 5
var grenades_left: int = 5
var done_spawning: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_spawning() -> void:
	grenades_left = num_grenades
	done_spawning = false
	spawn_grenade()


func spawn_grenade() -> void:
	var grenade = GRENADE_POWER_UP_SCENE.instantiate()
	add_child(grenade)
	grenade.make_visible()
	grenade.explode()
	$BetweenSpawnsTimer.start()


func _on_explosion_timer_1_timeout() -> void:
	for child in get_children():
		if child is GrenadePowerUp:
			child.queue_free()


func _on_between_spawns_timer_timeout() -> void:
	grenades_left -= 1
	if grenades_left <= 0:
		done_spawning = true
		$ExplosionTimer1.start()
	if not done_spawning:
		spawn_grenade()
		$BetweenSpawnsTimer.start()
