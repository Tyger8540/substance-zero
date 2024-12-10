class_name TargetPowerUpShopDisplay
extends HBoxContainer


var power_up: PowerUp


func _send_power_up_signal() -> void:
	Signals.gain_power_up.emit(power_up)
	
