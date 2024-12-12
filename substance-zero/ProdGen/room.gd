extends Node2D
class_name Room 
@export var map: TileMapLayer = null
@export var planetScene = preload("res://ProdGen/Tilemaps/BluePlanetTileMapLayer.tscn")
var ShopRoom = preload("res://ProdGen/Tilemaps/Planet1/PShop1.tscn")
var BossRoom = preload("res://ProdGen/Tilemaps/Planet1/PBoss1.tscn")
var TreasureRoom = preload("res://ProdGen/Tilemaps/Planet1/PTreasure1.tscn")
var planet = 0 

var tile_dict = { 
	"floor": []
}

var rng = RandomNumberGenerator.new() 

var exit_pos = null
var exit_side = null
var ent_side = null
var ent_pos = null 

func _ready() -> void:
	rng.randomize() 
	
	
func _init() -> void:
	map = createScene("planet")
	add_child(map)
	extract_tiles(map)

func extract_tiles(_map: TileMapLayer): 
	# extract floor tiles
	var tile_set = _map.tile_set
	for source_id in tile_set.get_source_count():
		if not tile_set.get_source(source_id) is TileSetAtlasSource:
			continue
		var source = tile_set.get_source(0)
		for tileId in source.get_tiles_count(): 
			var coord = source.get_tile_id(tileId)
			var tile = source.get_tile_data(coord,0)
			if tile.get_custom_data("tile"): 
				tile_dict.get("floor").append(coord)



func pick_a_tile(key:String):
	var values = tile_dict.get(key)
	if values == null: 
		print("No tile found for: ", key)
		return -1 
	return values[rng.randi()%values.size()]

func create_special_room(rtype:String): 
	map = createScene(rtype)
	add_child(map)
	map.z_index = -1
	
func create_room(sizeRange: Vector2):   
	# create floor  
	var width = rng.randi_range(sizeRange.x, sizeRange.y) 
	var height = rng.randi_range(sizeRange.x, sizeRange.y) 

	for x in range(width): 
		for y in range(height): 
			map.set_cell(Vector2i(x, y), 0,pick_a_tile("floor")) 
		
	# create walls  
	var wallmap = createScene("planet")
	map.add_child(wallmap)
	
	var wallcoord =[] 
	for x in range(width): 
		for y in range(height): 
			wallcoord.append(Vector2i(x, y)) 
	wallmap.set_cells_terrain_connect(wallcoord,0,1)
	for x in range(1, width-1): 
		for y in range(1, height-1): 
			wallmap.set_cell(Vector2i(x, y)) 

func createScene(sname: String): 
	var scene = null
	var texture = ["res://sprites/Tilesets/World1_Tilesets/tileset_blue.png",
	"res://sprites/Tilesets/World1_Tilesets/tileset_brown.png",
	"res://sprites/Tilesets/World1_Tilesets/tileset_gray.png",
	"res://sprites/Tilesets/World1_Tilesets/tileset_green.png",
	"res://sprites/Tilesets/World1_Tilesets/tileset_purple.png"][planet]
	
	if sname == "planet": 
		scene = planetScene
	if sname == "boss":
		scene = BossRoom
	elif sname == "treasure":
		scene = TreasureRoom 
	elif sname == "shop": 
		scene = ShopRoom
	
	var obj = scene.instantiate()
	(obj.tile_set.get_source(0) as TileSetAtlasSource).texture = load(texture)
	return obj 
func build_exit_path(dest: Vector2):
	var start = exit_pos
	var desti = map.local_to_map(to_local(dest))
	
	if !G.four_dir_opts.has(Vector2(desti-start).normalized()): 
		print(desti)
		print(start)
		print("Not a straight path!!")
		return 
		
	var pathmap = createScene("planet")
	pathmap.z_index += 1 
	add_child(pathmap) 

	var step = Vector2(desti - exit_pos).normalized()
	step = Vector2i(step)
	var current = start
	while current != desti: 
		pathmap.set_cell(current, 0, pick_a_tile("floor"))
		current += step
	# last final exit (entrance of new room)
	pathmap.set_cell(current, 0, pick_a_tile("floor"))

	
	
	
func set_cell(c:Vector2i,sid:int=-1,ac:Vector2i =Vector2i(-1,-1),alt: int=0):
	map.set_cell(c,sid,ac,alt)
	
func get_used_rect():
	return map.get_used_rect()
	
func create_rand_exit(newRoomSize: Vector2, secondExitDir):
	var options = G.four_dir_opts
	# exit must not be on the same side with entrance
	if ent_side != null: 
		options = options.filter(func(el): return el != ent_side)
		
	var dir = options[rng.randi()%options.size()]
	
	if secondExitDir != null and ent_side: 
		while G.is_u_shape([secondExitDir,-ent_side,dir]): 
			print("is u shape: ", [secondExitDir,-ent_side,dir])
			if options.size() > 1: 
				options = options.filter(func(el): return el != dir)
				dir = options[rng.randi()%options.size()]
			elif options.size() == 1: 
				dir = options.pop_back()
			else: 
				print("No more direction")
				return null
			print("new u shape option: ", dir)
	exit_side = dir  

	var mapsize = map.get_used_rect().size
	if exit_side == Vector2.UP or exit_side == Vector2.DOWN:    
		if mapsize.x > newRoomSize.x: 
			mapsize.x = newRoomSize.x 
	else: 
		if mapsize.y > newRoomSize.y: 
			mapsize.y = newRoomSize.y 

	# create exit position 
	
	var randomPos = func(): 	
		if dir == Vector2(0, 1):
			exit_pos = Vector2i(rng.randi_range(0, mapsize.x-1), mapsize.y-1)
		elif dir == Vector2(0, -1):
			exit_pos = Vector2i(rng.randi_range(0, mapsize.x-1), 0)
		elif dir == Vector2(1, 0):
			exit_pos = Vector2i(mapsize.x-1, rng.randi_range(0, mapsize.y-1))
		elif dir == Vector2(-1, 0):
			exit_pos = Vector2i(0, rng.randi_range(0, mapsize.y-1))
		else:
			print("Invalid direction")
			exit_pos = null 
	randomPos.call()
	while G.check_corner(exit_pos, mapsize):
		print("corner check exit")
		randomPos.call()


func create_entrance(exit_pos:Vector2, e:Vector2 = Vector2(0,0)):   
	if ent_side == null and e == Vector2(0,0):   
		print("No entrance side specified")
		return     
	if e != Vector2.ZERO: 
		if G.four_dir_opts.has(e): 
			ent_side = e
		else: 
			print("INVALID ENTRANCE")
			return

	var prevExit = map.local_to_map(to_local(exit_pos))   
	
	var mapsize = map.get_used_rect().size

	var randomPos = func(): 
		if ent_side == Vector2(0, 1):
			ent_pos = Vector2i(prevExit.x,mapsize.y-1)
		elif ent_side == Vector2(0, -1):
			ent_pos = Vector2i(prevExit.x,0)
		elif ent_side == Vector2(1, 0):
			ent_pos = Vector2i(mapsize.x-1, prevExit.y)
		elif ent_side == Vector2(-1, 0):
			ent_pos = Vector2i(0, prevExit.y)
		else:
			print("Invalid direction")
			ent_pos = null
	randomPos.call()
	# corner case
	while G.check_corner(ent_pos,map.get_used_rect().size):   
		print("corner check entrance ", ent_pos)
		randomPos.call()
