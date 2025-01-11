class_name ScenarioManager extends Node

@export var scenario_data : ScenarioData

@onready var camera:ScenarioCamera = $ScenarioCamera
var map:HexMap2D

signal scenario_map_zoomed_in
signal scenario_map_zoomed_out

var map_scale
var time_scale
var formation_scale

func _ready() -> void:
	#map = HexMap2D.new(scenario_data.start_hex)
	#map_scale = map.active_hex.hex_size
	#self.add_child(map)
	
	#Camera startup bits
	#var _cam_scn = load("res://scenario_camera.tscn")
	#camera = _cam_scn.instantiate()
	#self.add_child(camera)
	#camera.make_current()
	#camera.connect("camera_zoom_limit_in", _on_camera_zoom_limit_in)
	#camera.connect("camera_zoom_limit_out", _on_camera_zoom_limit_out)
	return

func _on_camera_zoom_limit_in():
	
	scenario_map_zoomed_in.emit()

func _on_camera_zoom_limit_out():
	
	scenario_map_zoomed_out.emit()
