class_name HexMap2D extends Node2D

@export var root_hex:HexData
@export var active_hex:HexData

var visible_hexes:Array[HexTile2D] = []

func _init(root:HexData, start:HexData) -> void:
	root_hex = root
	active_hex = start

func _ready() -> void:
	populate_hexes()

func populate_hexes() -> void:
	var new_hexes:Array[HexTile2D] = []
	
	for subhex in active_hex.subhexes:
			var new_hex = HexTile2D.build(subhex)
			for test_hex in new_hexes:
				if new_hex.local_coords.magnitude_2d(new_hex.local_coords.subtract(test_hex.local_coords)) != 0:
					new_hexes.append(new_hex)
	
	for hex in active_hex.get_neighbors():
		for subhex in hex.subhexes:
			var new_hex = HexTile2D.build(subhex)
			new_hex.local_coords.offset(HexVector2D.new(active_hex.local_coords.q-hex.local_coords_q, active_hex.local_coords.r-hex.local_coords_r, active_hex.local_coords.a-hex.local_coords_a), hex.hex_spacing)
			for test_hex in new_hexes:
				if new_hex.local_coords.magnitude_2d(new_hex.local_coords.subtract(test_hex.local_coords)) != 0:
					new_hexes.append(new_hex)
	
	for hex in new_hexes:
		if visible_hexes.has(hex) == false:
			visible_hexes.append(hex)
