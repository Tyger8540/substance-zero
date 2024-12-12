extends Node

signal player_death

# gain_power_up sent to power up manager from shop
signal gain_power_up(power_up: PowerUp)

# powerup shop internal signals
signal buying_power_up(power_up: PowerUp)
signal gain_melee_power_up
signal gain_target_power_up
signal gain_shield_power_up
signal gain_thrown_power_up
signal gain_boots_power_up
signal gain_red_bottle_power_up
signal gain_blue_bottle_power_up
signal shopping(shopping: bool)
