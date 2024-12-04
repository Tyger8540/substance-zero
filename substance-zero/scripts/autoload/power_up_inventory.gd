extends Node

# Store Power up Levels
# Different Powerups Can Have Different Lifespans, i.e. both a Permanent Melee Damage and Limited Melee Damage Upgrade
var power_up_level = {
	Enums.Power_Up_Lifespan.PERMANENT: {
		Enums.Power_Up_Type.MELEE_DAMAGE: 0,
		Enums.Power_Up_Type.GUN_DAMAGE: 0,
	},
	Enums.Power_Up_Lifespan.ROOM_LIMITED: {
		Enums.Power_Up_Type.MELEE_DAMAGE: 0,
		Enums.Power_Up_Type.GUN_DAMAGE: 0,
	},
	Enums.Power_Up_Lifespan.SINGLE_USE: {
		Enums.Power_Up_Type.MELEE_DAMAGE: 0,
		Enums.Power_Up_Type.GUN_DAMAGE: 0,
	},
}
