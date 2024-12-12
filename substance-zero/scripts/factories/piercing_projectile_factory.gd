# modified from exercise 3
class_name PiercingProjectileFactory
extends Node


func build(piercing_projectile_spec:PiercingProjectileSpec, character:Character) -> PiercingProjectile:
	var new_piercing_projectile = character.piercing_projectile.instantiate() as PiercingProjectile
	new_piercing_projectile.length = piercing_projectile_spec.length
	new_piercing_projectile.damage = piercing_projectile_spec.damage
	new_piercing_projectile.speed = piercing_projectile_spec.speed
	new_piercing_projectile.offset = piercing_projectile_spec.offset
	new_piercing_projectile.duration = piercing_projectile_spec.duration
	return new_piercing_projectile
