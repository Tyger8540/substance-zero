extends Node2D

var currLevel = 1 
var gener = null
var planet = 0
func restartGener(): 
	if gener != null: 
		gener.queue_free()
	gener = preload("res://ProdGen/ProdGenTest.tscn").instantiate()
	gener.genRes = loadres(currLevel)
	gener.planet = planet
	add_child(gener)
	return gener
	
func _ready() -> void: 
	var gener = restartGener()


func loadres(i):
	var pname = "res://ProdGen/levels/Level" + str(i) + "Gen.tres"
	return load(pname)


func _on_button_2_pressed() -> void:
	if currLevel == 4:
		currLevel = 1
	else: 
		currLevel += 1
	restartGener()


func _on_button_pressed() -> void:
	if currLevel == 1:
		return 
	currLevel -= 1
	restartGener()


func _on_option_button_item_selected(index: int) -> void:
	planet = index
	restartGener()
