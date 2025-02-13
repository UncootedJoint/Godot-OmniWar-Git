class_name ScenarioData extends Resource

@export_group("Scenario Properties")
@export var start_time_scale:int
@export var time_limit:int

@export_group("Map Properties")
@export var start_coords:Vector3i
@export var start_map_scale:int

@export var max_map_scale:int = 360000
@export var min_map_scale:int = 1

@export_group("Formations Properties")
@export var start_formation_scale:int = 1

@export var commands:Array[Array]
