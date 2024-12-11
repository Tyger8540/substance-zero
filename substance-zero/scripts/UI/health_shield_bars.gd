extends VBoxContainer


var health: float
var shield: float
var total_health: float
var total_shield: float

@onready var character: Character = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true


# Some code for process based on this video: https://www.youtube.com/watch?v=CSYxd94mnOU
func _process(delta: float) -> void:
	$ShieldBar.max_value = character.total_shield
	$HealthBar.max_value = character.total_health
	$ShieldBar.value = character.shield
	$HealthBar.value = character.health
	
	if character.health <= 0:
		visible = false
	
	
