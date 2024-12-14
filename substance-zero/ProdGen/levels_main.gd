extends Node2D

var currlevel:int = 1
var gener = null
var planet = 0
func restartGener(): 
	if gener != null: 
		gener.queue_free()
	gener = preload("res://ProdGen/ProdGenTest.tscn").instantiate()
	gener.genRes = loadres(currlevel)
	
	if (Global.planet_number > 4):
		Global.planet_number = 0
	gener.planet = Global.planet_number
	print("CURRENT LEVEL IS ", Global.planet_number)
	add_child(gener)
	return gener
	
func _ready() -> void: 
	var gener = restartGener()


func loadres(i):
	var pname = "res://ProdGen/levels/Level" + str(i) + "Gen.tres"
	return load(pname)


func _on_button_2_pressed() -> void:
	if currlevel == 4:
		currlevel = 1
	else: 
		currlevel += 1
	restartGener()


func _on_button_pressed() -> void:
	if currlevel == 1:
		return 
	currlevel -= 1
	restartGener()


func _on_option_button_item_selected(index: int) -> void:
	planet = index
	restartGener()
