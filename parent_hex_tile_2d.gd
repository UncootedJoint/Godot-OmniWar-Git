class_name ParentTile2D extends Node2D


func setup(coords, map_origin):
	var local_coords = coords.subtract(map_origin)
	position = Vector2(local_coords.hex_to_cartesian(local_coords, HexTile2D.pixel_spacing))