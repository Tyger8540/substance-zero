# modified from exercise 3
class_name MeleeFactory
extends Node


func build(melee_spec:MeleeSpec, character:Character) -> Melee:
	var new_melee = character.melee.instantiate() as Melee
	new_melee.length = melee_spec.length
	new_melee.damage = melee_spec.damage
	new_melee.duration = melee_spec.duration
	new_melee.offset = melee_spec.offset
	return new_melee
