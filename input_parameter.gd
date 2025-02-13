class_name InputParameter extends PanelContainer

@export var param_id:int

@export var param_min:float = 0.
@export var param_max:float = 100.
var param_value:float

@onready var comp_slider = $VBoxContainer/ComplexitySlider
@onready var comp_label = $VBoxContainer/HBoxContainer2/CompValue
@onready var param_label = $VBoxContainer/HBoxContainer2/ParamValue

func _ready() -> void:
	param_label.text = str(param_min)
	comp_label.text = str(comp_slider.min_value)

func _on_value_changed(new_value):
	var percent = new_value/comp_slider.max_value
	param_value = lerp(param_min, param_max, percent)
	param_label.text = str(param_value)
	comp_label.text = str(comp_slider.value)

func fetch_data(id):
	pass
