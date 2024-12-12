class_name BossProjectileFactory
extends Node

func build(projectile_spec:ProjectileSpec, boss:Boss1, target:Character) -> BossProjectile:
	var new_projectile = boss.boss_projectile.instantiate() as BossProjectile
	new_projectile.direction = calculate_direction(boss, target)
	new_projectile.length = projectile_spec.length
	new_projectile.damage = projectile_spec.damage
	new_projectile.speed = projectile_spec.speed
	new_projectile.offset = projectile_spec.offset
	new_projectile.duration = projectile_spec.duration
	return new_projectile


func calculate_direction(boss:Boss1, target:Character)-> Vector2 :
	var direction = boss.global_position - target.global_position
	return direction.normalized()
