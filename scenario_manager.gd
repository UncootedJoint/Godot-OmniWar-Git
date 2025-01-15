class_name ScenarioManager extends Node

@export var scenario_data : ScenarioData
@export var file_path:String = "res://default"

@onready var camera:ScenarioCamera = $ScenarioCamera
var map:HexMap2D

signal scenario_map_zoomed_in
signal scenario_map_zoomed_out
signal scenario_map_panned

var time_scale:int
var formation_scale:int

func _process(delta: float) -> void:
	#print(map.map_scale)
	return

func _ready() -> void:
	map = HexMap2D.new(
		HexVector2D.new(scenario_data.start_coords.x,scenario_data.start_coords.y,scenario_data.start_coords.z),
		scenario_data.start_scale
		)
	self.add_child(map)
	
	#Camera startup bits
	#var _cam_scn = load("res://scenario_camera.tscn")
	#camera = _cam_scn.instantiate()
	#self.add_child(camera)
	#camera.make_current()
	#camera.connect("camera_zoom_limit_in", _on_camera_zoom_limit_in)
	#camera.connect("camera_zoom_limit_out", _on_camera_zoom_limit_out)
	return

func _on_camera_zoom_limit_in():
	if map.map_scale > scenario_data.min_map_scale:
		scenario_map_zoomed_in.emit()

func _on_camera_zoom_limit_out():
	if map.map_scale < scenario_data.max_map_scale:
		scenario_map_zoomed_out.emit()

func _on_camera_pan_limit(offset) -> void:
	scenario_map_panned.emit(offset)
