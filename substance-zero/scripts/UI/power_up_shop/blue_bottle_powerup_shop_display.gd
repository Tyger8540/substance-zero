class_name BlueBottlePowerUpShopDisplay
extends HBoxContainer


var power_up: PowerUp


func _ready() -> void:
	Signals.gain_blue_bottle_power_up.connect(_on_gain_blue_bottle_power_up)
	$BuyButton.text = "Buy (%d)" % power_up.price
	
	
func _send_buying_signal() -> void:
	Signals.buying_power_up.emit(power_up)
	

func _on_gain_blue_bottle_power_up() -> void:
	$BuyButton.text = "Bought"
	$BuyButton.disabled = true