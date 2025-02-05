class_name HexTile2D extends Node2D

@export var data : Dictionary

@export var image:Sprite2D
static var pixel_spacing:int = 128

var local_coords:HexVector2D

func _ready() -> void:
	pass 

func setup(scn_coords:HexVector2D, map) -> void:
	data = fetch_data(map.db, Vector3i(scn_coords.q,scn_coords.r,map.map_scale))
	print(data)
	local_coords = HexVector2D.new(data["coords_q"],data["coords_r"],data["coords_a"]).subtract(map.origin)
	position = Vector2(local_coords.hex_to_cartesian(self.local_coords, pixel_spacing))
	#if self.data.texture != null:
		#var new_tex = $HexTexture
		#new_tex.texture = data.texture

func fetch_data(db:SQLite, coords:Vector3i) -> Dictionary:
	var selected = db.select_rows(
		"Hexes",
		"size = "+str(coords.z)+" AND coords_q = "+str(coords.x)+" AND coords_r = "+str(coords.y),
		["*"]
		)
	var result:Dictionary = {}
	var length = len(selected)
	if length == 1:
		result = selected[0]
	elif length == 0:
		result = generate_hex_data(coords, db)
	else:
		pass #error handling tbd
	return result


func generate_hex_data(coords:Vector3i, db) -> Dictionary:
	var new_data:Dictionary = {
		size = coords.z,
		coords_q = coords.x,
		coords_r = coords.y,
		coords_a = 0
	}
	db.insert_row("Hexes", new_data)
	var selected = db.select_rows(
		"Hexes",
		"size = "+str(coords.z)+" AND coords_q = "+str(coords.x)+" AND coords_r = "+str(coords.y),
		["*"]
		)
	var result:Dictionary
	if len(selected) == 1:
		result = selected[0]
	return result

func update_position() -> void:
	pass
