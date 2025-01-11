class_name HexTile2D extends Node2D

@export var data: HexData

@export var image:Sprite2D
var pixel_spcaing:int

var local_coords:HexVector2D

func _ready() -> void:
	pixel_spcaing = 140

func setup(hex_data:HexData,parent_offset:HexVector2D=HexVector2D.new(0,0,0)) -> void:
	data = hex_data
	local_coords = HexVector2D.new(data.coords_q, data.coords_r, data.coords_a)
	local_coords.offset(HexVector2D.new(data.parent.coords_q,data.parent.coords_r,data.parent.coords_a).subtract(parent_offset),data.parent_hex.spacing)
	position = Vector2(local_coords.hex_to_cartesian(self.local_coords, pixel_spcaing))

func update_position() -> void:
	pass
