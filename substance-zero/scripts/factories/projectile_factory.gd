# modified from exercise 3
class_name ProjectileFactory
extends Node


func build_player_projectile(projectile_spec:ProjectileSpec, character:Character) -> PlayerProjectile:
	var new_projectile = character.player_projectile.instantiate() as PlayerProjectile
	new_projectile.length = projectile_spec.length
	new_projectile.damage = projectile_spec.damage
	new_projectile.speed = projectile_spec.speed
	new_projectile.offset = projectile_spec.offset
	new_projectile.duration = projectile_spec.duration
	return new_projectile
	
	
func build_enemy_projectile(projectile_spec:ProjectileSpec, character:Character) -> EnemyProjectile:
	var new_projectile = character.enemy_projectile.instantiate() as EnemyProjectile
	new_projectile.length = projectile_spec.length
	new_projectile.damage = projectile_spec.damage
	new_projectile.speed = projectile_spec.speed
	new_projectile.offset = projectile_spec.offset
	new_projectile.duration = projectile_spec.duration
	return new_projectile
