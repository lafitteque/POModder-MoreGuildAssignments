extends Node2D

class_name DataForMod

const TILE_EMPTY := -1
const TILE_BORDER := 19
const TILE_IRON := 0
const TILE_WATER := 1
const TILE_SAND := 2
const TILE_GADGET := 3
const TILE_RELIC := 4
const TILE_NEST := 5
const TILE_RELIC_SWITCH := 6
const TILE_SUPPLEMENT := 7
const TILE_CAVE := 9
const TILE_DIRT_START := 10
const TILE_DETONATOR := 11 # QLafitte Added

const TILE_ID_TO_STRING_MAP := {
	TILE_EMPTY: "",
	TILE_BORDER: CONST.BORDER,
	TILE_IRON: CONST.IRON,
	TILE_WATER: CONST.WATER,
	TILE_SAND: CONST.SAND,
	TILE_GADGET: CONST.GADGET,
	TILE_RELIC: CONST.RELIC,
	TILE_NEST: CONST.NEST,
	TILE_RELIC_SWITCH: CONST.RELICSWITCH,
	TILE_SUPPLEMENT: CONST.POWERCORE,
	TILE_DETONATOR :"detonator" 
} 

const DROP_FROM_TILES_SCENES := {
	CONST.IRON: preload("res://content/drop/iron/IronDrop.tscn"),
	CONST.WATER: preload("res://content/drop/water/WaterDrop.tscn"),
	CONST.SAND: preload("res://content/drop/sand/SandDrop.tscn"),
	"cavebomb" : preload("res://content/caves/bombcave/CaveBomb.tscn"),
	"nothing" : null
}

const APRIL_FOOLS_PROBABILITIES = [50.0, 5.0 , 2.0 , 1.0, 20.0]

static func weighted_random(weights) -> int:
	var weights_sum := 0.0
	for weight in weights:
		weights_sum += weight
	
	var remaining_distance := randf() * weights_sum
	for i in weights.size():
		remaining_distance -= weights[i]
		if remaining_distance < 0:
			return i
	
	return 0

const ACHIEVEMENTS := [
	"SHIELD_STRONG",
	"RESOURCES_COBALTSTACK",
	"RESOURCES_COBALTRESCUE",
	"REPELLENT_BIGDELAY",
	"RELICHUNT_SPEEDY",
	"PRESTIGE_WIN",
	"PROBE_USE",
	"PRESTIGE_MULTIPLIER",
	"PRESTIGE_CHUNK",
	"PET_FOUND",
	"ORCHARD_LONG",
	"MINE_ALL",
	"LIFT_JAM",
	"LIFT_TRANSPORT",
	"KEEPER_TIMELY",
	"KEEPER_BOTTOM",
	"KEEPER_MARATHON",
	"KEEPER2_SPHEREDURATION",
	"KEEPER2_REFLECTIONS",
	"KEEPER2_AMMO",
	"KEEPER2_BIGBUNDLE",
	"KEEPER1_SPEED",
	"KEEPER1_SHOPPINGBAG",
	"DOME_LOWHEALTH",
	"DRILLBERT_TREAT",
	"CONVERTER_USE",
	"BLASTMINING_USE",
	"CONDENSER_USE",
	"RELICHUNT_RELICTAKEN",
	"KEEPER2_EXPLODE",
	"KEEPER2_SPLITS",
	"RELICHUNT_MAPSMALL",
	"RELICHUNT_MAPMEDIUM",
	"RELICHUNT_MAPLARGE",
	"RELICHUNT_BEATFINALE"
]
