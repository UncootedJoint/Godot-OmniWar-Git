class_name HexTile2D extends Node2D

@export var tile_data: HexData
static var scene:PackedScene = load("res://hex_tile_2d.tscn")
@export var image:Sprite2D

var local_coords:HexVector2D
var global_coords:HexVector2D

static func build(data:HexData) -> HexTile2D:
	var new_hex = scene.instantiate()
	new_hex.tile_data = data
	return new_hex

func _init() -> void:
	pass

func _ready() -> void:
	self.global_position = self.local_coords.hex_to_cartesian()

func get_neighbors() -> Array[HexData]:
	var neighbors :Array[HexData] = []
	for hex in self.parent_hexes:
		for sibling in hex.subhexes:
			if sibling.local_coords.dist_between(self.local_coords) <= 1:
				neighbors.append(hex)
	return neighbors
