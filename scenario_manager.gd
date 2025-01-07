extends Node

@export var scenario_data : ScenarioData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var map = HexMap2D.new(scenario_data.root_hex, scenario_data.start_hex)
	self.add_child(map)
	
	var camera:Camera2D = Camera2D.new()
	self.add_child(camera)
	
