extends SingleUsePowerUp

const GODOT_ICON = preload("res://icon.svg")

var max_shield_health: float = 100.0
var shield_health: float

var in_use: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $HitBox/Collider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_shield_inactive()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("use_power_up") and not in_use and uses > 0:
		use_power_up()


func use_power_up() -> void:
	set_shield_active()
	super()


func set_shield_active() -> void:
	in_use = true
	shield_health = max_shield_health
	sprite.texture = GODOT_ICON
	collider.set_deferred("disabled", false)  # enables the hitbox's collider


func set_shield_inactive() -> void:
	in_use = false
	sprite.texture = null
	collider.set_deferred("disabled", true)  # disables the hitbox's collider


func take_damage(damage:float) -> void:
	shield_health -= damage
	if shield_health <= 0.0:
		set_shield_inactive()
	elif shield_health <= 0.25 * max_shield_health:
		# TODO
		# Sets the texture to red to symbolize quarter health
		pass
	elif shield_health <= 0.5 * max_shield_health:
		# TODO
		# Sets the texture to yellow/orange to symbolize half health
		pass
		
