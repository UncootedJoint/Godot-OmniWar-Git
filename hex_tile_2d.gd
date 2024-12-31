class_name HexTile2D extends Node2D

@export var tile_data: HexData

var local_coords:HexVector2D
var local_altitude:float

var global_coords:HexVector2D
var global_altitude:float

var hex_scale:int #the number of subhexes across the hex is
var size_in_base_units:int

func _init(new_data:HexData = null) -> void:
	if tile_data == null:
		tile_data = new_data
	
func _ready() -> void:
	return

func get_neighbors() -> Array[HexData]:
	for hex in self.parent_hex.parent_hex.subhexes:
		pass
		
func get_super_neighbors():
	#var local_offset
	#get each hex in the parent_hex.subhexes
	#add the local coords * the scale step factor to create an offset value
	#for each hex, add to array with the offset value added to local coords relative to active hex
	pass
