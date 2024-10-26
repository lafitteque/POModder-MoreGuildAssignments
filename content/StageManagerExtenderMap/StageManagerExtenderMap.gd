extends Node2D

var stage = null
var tiles = null
@onready var stage_manager = get_parent()


func _on_timer_timeout():
	if !stage or stage_manager.currentStage.name != stage.name:
		stage_changed()
		
func stage_changed():
	stage = stage_manager.currentStage
	tiles = stage_manager.find_child("Tiles",true ,false)
	await get_tree().create_timer(1)
	if tiles :
		print("Tiles Extender Ajouté")
		var tiles_extender = preload("res://mods-unpacked/POModder-MoreGuildMissions/content/StageManagerExtenderMap/TilesExtender.tscn").instantiate()
		tiles.add_child(tiles_extender)
	else :
		tiles = null
