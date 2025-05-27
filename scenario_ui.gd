class_name ScenarioUI extends CanvasLayer

@onready var m_scale_label = $BottomBar/VBoxContainer/MapControlBox/HBoxContainer/Current
@onready var t_scale_label = $BottomBar/VBoxContainer/TimeControlBox/HBoxContainer/Current

func _ready() -> void:
	pass

func _on_scenario_map_zoomed_in() -> void:
	m_scale_label.text

func _on_scenario_map_zoomed_out() -> void:
	pass # Replace with function body.
