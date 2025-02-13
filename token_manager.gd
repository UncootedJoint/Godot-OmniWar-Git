class_name TokenManager extends Node2D

@onready var scenario:ScenarioManager = $/root/ScenarioManager



func _ready() -> void:
	scenario.connect("scenario_turn_ended", _on_scenario_turn_ended)
	
	

func _on_scenario_turn_ended():
	pass

func create_elemants():
	for data in scenario.scenario_data.commands:
		
