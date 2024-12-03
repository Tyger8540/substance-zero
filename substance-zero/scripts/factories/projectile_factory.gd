# modified from exercise 3
class_name ProjectileFactory
extends Node


func build(projectile_spec:ProjectileSpec, character:Character) -> Projectile:
	var new_projectile = character.projectile.instantiate() as Projectile
	new_projectile.length = projectile_spec.length
	new_projectile.damage = projectile_spec.damage
	new_projectile.speed = projectile_spec.speed
	new_projectile.offset = projectile_spec.offset
	new_projectile.duration = projectile_spec.duration
	return new_projectile
