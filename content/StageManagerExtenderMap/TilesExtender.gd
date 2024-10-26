extends Node2D

var revealed_tiles_coord = []
var drop_already_updated = []

@onready var tiles = get_parent()
@onready var map = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	if Data.of("assignment.id") is String and Data.of("assignment.id") == "aprilfools": 
		var drop_timer = Timer.new()
		add_child(drop_timer)
		drop_timer.autostart = true
		drop_timer.wait_time = 0.1
		drop_timer.timeout.connect(update_drops)
		drop_timer.start()
		
		var clear_drop_timer = Timer.new()
		add_child(clear_drop_timer)
		clear_drop_timer.autostart = true
		clear_drop_timer.wait_time = 5
		clear_drop_timer.timeout.connect(clear_drops)
		clear_drop_timer.start()
		

func clear_drops():
	for i in range(drop_already_updated.size()-1,-1,-1):
		if not(is_instance_valid(drop_already_updated[i]) ):
			drop_already_updated.pop_at(i)
		
	
func update_drops():
	for drop in get_tree().get_nodes_in_group("drops"):
		if drop in drop_already_updated:
			continue
		print("test : drop = ", drop.type)
		if ("type" in drop) and drop.type in [CONST.WATER, CONST.IRON,CONST.SAND]:
			
			var old_position = drop.global_position #QLafitte Added
			drop.queue_free()
			var all_keys = DataForMod.DROP_FROM_TILES_SCENES.keys() #QLafitte Added
			var rand_type = all_keys[DataForMod.weighted_random(DataForMod.APRIL_FOOLS_PROBABILITIES)] #QLafitte Added
			if rand_type == "nothing":
				return
			print("Test : drop transformé en ", rand_type)
			var new_drop = DataForMod.DROP_FROM_TILES_SCENES.get(rand_type).instantiate()#QLafitte Added
			map.add_child(new_drop)
			new_drop.global_position = old_position #QLafitte Added
			new_drop.apply_central_impulse(Vector2(0, 40).rotated(randf() * TAU))#QLafitte Added
			drop_already_updated.append(new_drop)
			
			
			
func _on_timer_timeout():
	for tile in tiles.get_children():
		if not(tile is Tile) or tile.coord in revealed_tiles_coord :
			continue
		elif map.tileData.get_resource(tile.coord.x, tile.coord.y) == DataForMod.TILE_DETONATOR:
			tile.setType(DataForMod.TILE_ID_TO_STRING_MAP[DataForMod.TILE_DETONATOR])
			map.revealTileVisually(tile.coord) 
			revealed_tiles_coord.append(tile.coord)
			tile.res_sprite.hide()
			set_meta("destructable", true)
			tile.initResourceSprite(Vector2(5, 0))
			var detonator = load("res://mods-unpacked/POModder-MoreGuildMissions/content/detonator_tile/Detonator.tscn").instantiate()#QLafitte Added
			detonator.position = position#QLafitte Added
			tile.add_child(detonator)#QLafitte Added
			
			tile.destroyed.connect(detonator.explode)
		elif Data.of("assignment.id") is String and Data.of("assignment.id") == "aprilfools":
			if tile.type in [CONST.IRON, CONST.SAND, CONST.WATER, DataForMod.TILE_DETONATOR]: 
				var vec_list = [\
					Vector2(5, 0) , Vector2(randi_range(2, 6), 11) , \
					Vector2(2, 3) , Vector2(randi_range(2, 3), 7) , \
					Vector2(4, 1), Vector2(4, 1), Vector2(4, 2),\
					Vector2(4, 2), Vector2(5, 0)]
				var rand_index = randi_range(0,8) 
				tile.initResourceSprite(vec_list[rand_index]) 
			revealed_tiles_coord.append(tile.coord)
		
		
func _on_revealed_tiles_cleaner_timeout():
	for index in range(revealed_tiles_coord.size()-1,-1,-1):
		var coord = revealed_tiles_coord[index]
		if not( coord in map.visuallyRevealedTiles):
			revealed_tiles_coord.pop_at(index)
