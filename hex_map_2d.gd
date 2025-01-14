class_name HexMap2D extends Node2D

@onready var scenario:ScenarioManager = $/root/ScenarioManager
@onready var tile_scn = load("res://../hex_tile_2d.tscn")

var origin:HexVector2D
var map_scale:int

func _init(start_coords:HexVector2D,start_scale:int) -> void:
	origin = start_coords
	map_scale = start_scale

func _ready() -> void:
	scenario.connect("scenario_map_zoomed_in", _on_scenario_zoomed_in)
	scenario.connect("scenario_map_zoomed_out", _on_scenario_zoomed_out)
	populate_hexes()

func _on_scenario_zoomed_in():
	populate_hexes()

func _on_scenario_zoomed_out():
	populate_hexes()

func populate_hexes() -> void:
	for node in self.get_children():
		node.queue_free()
	for coords in origin.get_coords_in_radius(2):
		var new_tile = tile_scn.instantiate()
		add_child(new_tile)
		new_tile.setup(HexVector2D.new(coords.q,coords.r,map_scale))
