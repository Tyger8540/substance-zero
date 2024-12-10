class_name MeleePowerUpShopDisplay
extends HBoxContainer


var power_up: PowerUp


func _send_power_up_signal() -> void:
	print("sending power up")
	Signals.gain_power_up.emit(power_up)
	
