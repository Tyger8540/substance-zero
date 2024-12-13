# modified from exercise 3
class_name MeleeFactory
extends Node


func build_player_melee(melee_spec:MeleeSpec, character:Character) -> PlayerMelee:
	var new_melee = character.player_melee.instantiate() as PlayerMelee
	new_melee.length = melee_spec.length
	new_melee.damage = melee_spec.damage
	new_melee.duration = melee_spec.duration
	new_melee.offset = melee_spec.offset
	return new_melee
	
	
func build_enemy_melee(melee_spec:MeleeSpec, character:Character) -> EnemyMelee:
	var new_melee = character.enemy_melee.instantiate() as EnemyMelee
	new_melee.length = melee_spec.length
	new_melee.damage = melee_spec.damage
	new_melee.duration = melee_spec.duration
	new_melee.offset = melee_spec.offset
	return new_melee
