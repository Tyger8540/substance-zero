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
	SHIELD_BOOST, #possible idea
	BUBBLE_SHIELD, #SINGLE_USE only
	GRENADE, #possible idea (SINGLE_USE only)
}
