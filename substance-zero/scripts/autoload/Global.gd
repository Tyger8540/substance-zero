extends Node
class_name G

const CELL_SIZE = 16
const four_dir_opts = [Vector2.UP, Vector2.DOWN,Vector2.LEFT, Vector2.RIGHT]

var room_position_array:Array[Vector2] = []
var dimensions_array:Array[Vector2] = []
var rooms_spawned:bool = false

var planet_number:int


static func map_to_global(map: TileMapLayer, coord: Vector2i): 
	return map.to_global(map.map_to_local(coord))

static func check_corner(coord:Vector2, size: Vector2):  
	if coord.x < 0 or coord.y < 0 or coord.x >= size.x or coord.y >= size.y:
		return false	 

	if coord.x == 0 and coord.y == 0: 
		return true	 
	if coord.x == 0 and coord.y == size.y-1: 
		return true	 
	if coord.x == size.x-1 and coord.y == 0:	
		return true	 
	if coord.x == size.x-1 and coord.y == size.y-1:	 
		return true
	return false
	
	pass
	
static func is_u_shape(vectors: Array) -> bool:
	if vectors.size() != 3:
		return false  # U-shape requires exactly 3 vectors
	
	var v1 = vectors[0]
	var v2 = vectors[1]
	var v3 = vectors[2]
	
	# Ensure all vectors are cardinal directions
	if not (is_cardinal(v1) and is_cardinal(v2) and is_cardinal(v3)):
		return false
	
	# Check if the first and last vectors are opposite
	if v1 + v3 != Vector2.ZERO:
		return false
	
	# Check if the middle vector is perpendicular to the first (or last)
	if abs(v1.dot(v2)) != 0:
		return false
	
	return true

# Helper function to check if a vector is a cardinal direction
static func is_cardinal(vec: Vector2) -> bool:
	return four_dir_opts.has(vec)

static var rng = RandomNumberGenerator.new() 
static func pickPercent(per: int): 
	if per >= rng.randi()%100+1: 
		return true 
	return false
