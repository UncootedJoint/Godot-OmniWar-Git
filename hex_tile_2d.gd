class_name HexTile2D extends Node2D

@export var data: HexData

@export var image:Sprite2D
const pixel_spcaing:int = 140

var local_coords:HexVector2D

func _ready() -> void:
	pass

func setup(scn_coords:HexVector2D) -> void:
	var map = get_parent()
	data = self.get_data(Vector3i(scn_coords.q+map.origin.q,scn_coords.r+map.origin.r,map.map_scale),map.scenario.file_path)
	local_coords = HexVector2D.new(data.coords_q,data.coords_r,data.coords_a).subtract(map.origin)
	position = Vector2(local_coords.hex_to_cartesian(self.local_coords, pixel_spcaing))

func get_data(global_coords:Vector3i,data_loc:String) -> HexData:
	var data_path:String = data_loc + "/map_data/hx_%s_%s_%s.tres" % [global_coords.z,global_coords.x,global_coords.y]
	var new_data = load(data_path)
	if new_data == null:
		new_data = generate_hex_data(data_loc, global_coords)
	return new_data

func generate_hex_data(folder:String, coords:Vector3i) -> HexData:
	var new_data:HexData = HexData.new(HexVector2D.new(coords.x,coords.y), coords.z)
	var full_path: String = "%s/map_data/hx_%s_%s_%s.tres" % [folder, coords.z, coords.x, coords.y]
	ResourceSaver.save(new_data, full_path)
	return new_data

func update_position() -> void:
	pass
