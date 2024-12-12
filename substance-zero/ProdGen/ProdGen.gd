extends Node2D
class_name ProdGen
var rng = RandomNumberGenerator.new() 


# room distance range

@export var genRes: LevelGenRes
var sizeRange = null
var roomDistanceRange = null
var planet = 0

var position_array = []

func _ready():
	rng.randomize()
	sizeRange = genRes.sizeRange 
	roomDistanceRange = genRes.roomDistanceRange
	spawn_rooms(genRes.roomCount)

func get2ndRecentExitSide(arr: Array):
	if arr.size() < 2: 
		return null  
	
	return arr[arr.size()-2]

func pick(range:Vector2): 	
	return randi_range(range.x,range.y)
	 
func spawn_rooms(roomCount: int): 
	var prevRoom = null
	var prevExitDirs = []
	
	# track special rooms 
	var sroom:Dictionary = { 
		"boss": pick(genRes.bossRange),
		"shop": pick(genRes.shopsRange),
		"treasure":pick(genRes.treasuresRange),
	}
	var isSroomEmpty = func(): 
		for val in sroom.values(): 
			if val != 0: 
				return false 
		return true
		
	var totalSroom = func(): 
		var sum = 0 
		for val in sroom.values(): 
			sum += val
		return sum 
		
	var count = roomCount+ totalSroom.call()
	
	var pickSroom = func(): 
		if isSroomEmpty.call(): 
			return null
		var opts =  sroom.keys().filter(func(el): return sroom.get(el) > 0)
		var picked = opts[rng.randi()%opts.size()]
		sroom[picked] -= 1
		return picked
	 
	# pick sroom.count() from count
	# spawn
	var	sRoomIdxs = range(count)
	sRoomIdxs.shuffle()
	sRoomIdxs = sRoomIdxs.slice(0,totalSroom.call())
	for i in range(count):
		print("ROOM ",i) 
		var rtype = pickSroom.call() if sRoomIdxs.has(i) else null
		print("Type ", rtype)
		var newRoom = spawn_room(prevRoom,get2ndRecentExitSide(prevExitDirs),rtype)
		prevRoom = newRoom
		prevExitDirs.append(-newRoom.ent_side if newRoom.ent_side else null)
		print("exit: ",-newRoom.ent_side if newRoom.ent_side else "none")


func spawn_room(prevRoom: Room = null, secondExitDir = null, rtype = null):  
	# first room 
	var currentRoom = Room.new()
	currentRoom.planet = planet
	if rtype != null: 
		currentRoom.create_special_room(rtype)
	else: 
		currentRoom.create_room(sizeRange)
	if prevRoom == null: 
		add_child(currentRoom)
		
	else:  
		# finding the location for new room
		var prevRoomSize = Vector2(prevRoom.get_used_rect().size)
		var currentRoomSize = Vector2(currentRoom.get_used_rect().size)
		
		# create exit
		if prevRoom.exit_side == null: 
			prevRoom.create_rand_exit(currentRoomSize,secondExitDir) 
		var dir = prevRoom.exit_side 
		currentRoom.ent_side = -prevRoom.exit_side
		
		# find direction 
		var offset = dir * randi_range(roomDistanceRange.x,roomDistanceRange.y) 
		var xOffset = offset.x 
		var yOffset = offset.y
		
		# top 
		if yOffset < 0: 
			yOffset -= currentRoomSize.y 
		if xOffset > 0: 
			xOffset += prevRoomSize.x
		if xOffset < 0: 
			xOffset -= currentRoomSize.x 
		if yOffset > 0: 
			yOffset += prevRoomSize.y
 
		
		add_child(currentRoom) 
		currentRoom.global_position = prevRoom.global_position + Vector2(xOffset, yOffset) * G.CELL_SIZE
		Global.room_position_array.append(currentRoom.global_position)
		print("room position array")
		print(Global.room_position_array)
		
		# build corridors 
		if currentRoom.ent_pos == null: 
			if prevRoom.exit_pos == null:
				print("error, no exit_pos") 

			currentRoom.create_entrance(G.map_to_global(prevRoom.map, prevRoom.exit_pos))
		var desti = G.map_to_global(currentRoom.map,currentRoom.ent_pos)
		prevRoom.build_exit_path(desti)

		 
	return currentRoom
