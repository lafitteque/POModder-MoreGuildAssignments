extends Node

const MYMODNAME_LOG = "POModder-MoreGuildAssignments"
const MYMODNAME_MOD_DIR = "POModder-MoreGuildAssignments/"


var cooldown : float = 1.0
var in_game = false
var map_node = null

var dir = ""
var ext_dir = ""
var trans_dir = ""

var overwrites_dir = "res://mods-unpacked/POModder-MoreGuildAssignments/overwrites/"

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
	#ModLoaderMod.install_script_extension(ext_dir + "Achievement_MINE_ALL.gd")
	ModLoaderMod.install_script_extension(ext_dir + "AssignmentDisplay.gd")
	ModLoaderMod.install_script_extension(ext_dir + "TileDataGenerator.gd")
	var pathToModYaml : String = "res://mods-unpacked/POModder-MoreGuildAssignments/yaml/assignments-complete.yaml"
	ModLoaderLog.info("Trying to parse YAML: %s" % pathToModYaml, MYMODNAME_LOG)
	Data.parseAssignmentYaml(pathToModYaml)
	
	StageManager.connect("level_ready", _on_level_ready)
	manage_overwrites()	
	
	#var stage_manager_extender = preload("res://mods-unpacked/POModder-MoreGuildAssignments/content/StageManagerExtenderMap/StageManagerExtenderMap.tscn").instantiate()
	#get_tree().get_root().find_child("StageManager",false,false).add_child(stage_manager_extender)
	
# Called when the node enters the scene tree for the first time.
func manage_overwrites():
	var new_archetype = preload("res://mods-unpacked/POModder-MoreGuildAssignments/maparchetypes/assignment-detonators.tres")
	new_archetype.take_over_path("res://content/map/generation/archetypes/assignment-detonators.tres")

	var new_archetype2 = preload("res://mods-unpacked/POModder-MoreGuildAssignments/maparchetypes/assignment-aprilfools.tres")
	new_archetype2.take_over_path("res://content/map/generation/archetypes/assignment-aprilfools.tres")
	
	
func _on_level_ready():
	var tiles = get_tree().get_root().find_child("Tiles",true ,false)
	if tiles :
		#DataForMod.add_message(get_tree().get_root().get_child(13).map,"TileExtender Ajouté",Vector2.UP*300)
		var tiles_extender = preload("res://mods-unpacked/POModder-MoreGuildAssignments/content/TilesExtender/TilesExtender.tscn").instantiate()
		tiles.add_child(tiles_extender)
	else :
		tiles = null

	if Data.ofOr("assignment.id","")  == "thieves":
		var drop_bearer_manager = preload("res://mods-unpacked/POModder-MoreGuildAssignments/content/drop_bearer/drop_bearer_manager.tscn").instantiate()
		StageManager.currentStage.MAP.add_child(drop_bearer_manager)
	print(Data.ofOr("assignment.id",""))
	if Data.ofOr("assignment.id","")  == "mineall":
		var mine_all_data = preload("res://mods-unpacked/POModder-MoreGuildAssignments/content/mine_all/mine_all_data.tscn").instantiate()
		print(StageManager.currentStage.name)
		add_child(mine_all_data)
