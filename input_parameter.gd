class_name InputParameter extends PanelContainer

@export var param_id:int

@export var param_min:float = 0.
@export var param_max:float = 100.
@export var comp_min:int = 1
@export var comp_max:int = 10
@export var param_steps:int = 10

var param_value:float
var comp_value:float

signal slider_updated

@onready var input_slider = $VBoxContainer/InputSlider
@onready var comp_label = $VBoxContainer/HBoxContainer2/CompValue
@onready var param_label = $VBoxContainer/HBoxContainer2/ParamValue

func _ready() -> void:
	param_label.text = str(param_min)
	comp_label.text = str(comp_min)
	

func _on_value_changed(new_value):
	var percent = (new_value - input_slider.min_value)/(input_slider.max_value - input_slider.min_value)
	param_value = lerp(param_min, param_max, percent)
	param_value = snapped(param_value, .001)
	comp_value = clamp(new_value, comp_min, comp_max)
	param_label.text = str(param_value)
	comp_label.text = str(comp_value)
	
	slider_updated.emit()

func fetch_data(id, db_path):
	param_id = id
	var db = SQLite.new()
	db.set_path(db_path)
	db.open_db()
	var data = db.select_rows(
		"calculated_parameters",
		"ID = "+str(id),
		["*"]
	)
	data = data[0]
	pass
	input_slider.min_value = comp_min
	input_slider.max_value = comp_min + param_steps
	input_slider.tick_count = param_steps
