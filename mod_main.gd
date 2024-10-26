extends Node

const MYMODNAME_LOG = "POModder-MoreGuildMissions"
const MYMODNAME_MOD_DIR = "POModder-MoreGuildMissions/"


var cooldown : float = 1.0
var in_game = false
var map_node = null

var dir = ""
var ext_dir = ""
var trans_dir = ""

var overwrites_dir = "res://mods-unpacked/POModder-MoreGuildMissions/overwrites/"

func _init():
	ModLoaderLog.info("Init", MYMODNAME_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	ext_dir = dir + "extensions/"
	trans_dir = dir + "translations/"
	for loc in ["en" , "es" , "fr"]:
		ModLoaderMod.add_translation(trans_dir + "translations." + loc + ".translation")

func _ready():
	ModLoaderLog.info("Done", MYMODNAME_LOG)
	add_to_group("mod_init")

	
	
func modInit():
	ModLoaderMod.install_script_extension(ext_dir + "Achievement_MINE_ALL.gd")
	ModLoaderMod.install_script_extension(ext_dir + "AssignmentDisplay.gd")
	ModLoaderMod.install_script_extension(ext_dir + "TileDataGenerator.gd")
	var pathToModYaml : String = "res://mods-unpacked/POModder-MoreGuildMissions/yaml/assignments-complete.yaml"
	ModLoaderLog.info("Trying to parse YAML: %s" % pathToModYaml, MYMODNAME_LOG)
	Data.parseAssignmentYaml(pathToModYaml)
	
	StageManager.connect("level_ready", _on_level_ready)
	manage_overwrites()	
	var stage_manager_extender = preload("res://mods-unpacked/POModder-MoreGuildMissions/content/StageManagerExtenderMap/StageManagerExtenderMap.tscn").instantiate()
	get_tree().get_root().get_child(10).add_child(stage_manager_extender)
	
# Called when the node enters the scene tree for the first time.
func manage_overwrites():
	var new_archetype = preload("res://mods-unpacked/POModder-MoreGuildMissions/overwrites/assignment-detonators.tres")
	new_archetype.take_over_path("res://content/map/generation/archetypes/assignment-detonators.tres")

	var new_archetype2 = preload("res://mods-unpacked/POModder-MoreGuildMissions/overwrites/assignment-aprilfools.tres")
	new_archetype2.take_over_path("res://content/map/generation/archetypes/assignment-aprilfools.tres")
	
	var tile_scene = preload("res://mods-unpacked/POModder-MoreGuildMissions/it_hurts/Tile.tscn")
	tile_scene.take_over_path("res://content/map/tile/Tile.tscn")

	
	
func _on_level_ready():
	if Data.of("assignment.id") is String and Data.of("assignment.id") == "thieves":
		var drop_bearer_manager = preload("res://mods-unpacked/POModder-MoreGuildMissions/content/drop_bearer/drop_bearer_manager.tscn").instantiate()
		get_tree().get_root().get_child(13).map.add_child(drop_bearer_manager)
