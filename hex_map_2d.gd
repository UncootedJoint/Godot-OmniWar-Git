class_name HexMap2D extends Node2D

@onready var scenario:ScenarioManager = $/root/ScenarioManager
@onready var tile_scn = load("res://../hex_tile_2d.tscn")
@onready var parent_scn = load("res://parent_hex_tile_2d.tscn")

var origin:HexVector2D
var map_scale:int

func _init(start_coords:HexVector2D,start_scale:int) -> void:
	origin = start_coords
	map_scale = start_scale

func _ready() -> void:
	scenario.connect("scenario_map_zoomed_in", _on_scenario_map_zoomed_in)
	scenario.connect("scenario_map_zoomed_out", _on_scenario_map_zoomed_out)
	scenario.connect("scenario_map_panned", _on_scenario_map_panned)
	scenario.camera.connect("camera_panned", _on_camera_panned)
	call_deferred("populate_hexes")

func _on_scenario_map_zoomed_in():
	map_scale = map_scale / 10
	populate_hexes()

func _on_scenario_map_zoomed_out():
	map_scale = map_scale * 10
	populate_hexes()

func _on_scenario_map_panned(offset:HexVector2D):
	origin = origin.add(offset)
	populate_hexes()

func _on_camera_panned():
	populate_hexes()

func populate_hexes() -> void:
	for node in get_children():
		node.queue_free()
	
	for coords in origin.get_coords_in_radius(25):
		var new_tile = tile_scn.instantiate()
		add_child(new_tile)
		new_tile.setup(HexVector2D.new(coords.q,coords.r,map_scale))
		
		if fmod(coords.q,10.0) == 0 and fmod(coords.r,10.0) == 0:
			var parent_tile = parent_scn.instantiate()
			add_child(parent_tile)
			parent_tile.setup(coords, origin)
