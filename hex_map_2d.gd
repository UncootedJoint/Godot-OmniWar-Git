class_name HexMap2D extends Node2D

@onready var scenario:ScenarioManager = $/root/ScenarioManager
@onready var tile_scn = load("res://../hex_tile_2d.tscn")

@export var active_hex:HexData
var active_offset:HexVector2D

func _init(start:HexData) -> void:
	active_hex = start
	active_offset = HexVector2D.new(active_hex.coords_q,active_hex.coords_r,active_hex.coords_a)

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
	
	var queue:Array[HexData] = []
	for hex in active_hex.subhexes:
		queue.append(hex)
	var neighbors = active_hex.get_neighbors()
	for neighbor in neighbors:
		for hex in neighbor.subhexes:
			if queue.has(hex) == false:
				queue.append(hex)
	
	for data in queue:
		var new_hex = tile_scn.instantiate()
		self.add_child(new_hex)
		new_hex.setup(data,active_offset)
