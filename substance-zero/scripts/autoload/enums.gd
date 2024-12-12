extends Node

enum Power_Up_Lifespan {
	PERMANENT,
	ROOM_LIMITED,
	SINGLE_USE,
}

enum Power_Up_Type {
	MELEE_DAMAGE,
	RANGED_DAMAGE,
	HEALTH_BOOST,
	SHIELD_BOOST,
	BUBBLE_SHIELD, #SINGLE_USE
	GRENADE, #SINGLE_USE
	EXPLODING_DASH, #ROOM_LIMITED
	
}
