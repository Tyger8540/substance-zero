class_name BubbleShieldPowerUp
extends PowerUp

@onready var shield: Sprite2D = $Shield
var health := 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(lifespan)


func swap_textures(new_texture : Texture2D) -> void:
	if (health < 10):
		shield.texture = load("res://sprites/characters/Weapons/Shield Colour/Shield_Red.png")
	if (health < 50):
		shield.texture = load("res://sprites/characters/Weapons/Shield Colour/Shield_Yellow.png")
