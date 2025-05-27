class_name ComponentPattern extends PanelContainer

@export var pattern_id:int
@export var db_path:String = "res://database/universe_test.db"

var compo_scn = load("res://component_pattern.tscn")
var input_scn = load("res://input_parameter.tscn")
var calc_scn = load("res://calculated_parameter.tscn")

@onready var name_label = $VBoxContainer/NameLabel
@onready var type_label = $VBoxContainer/HBoxContainer/TypeLabel
@onready var tl_label = $VBoxContainer/HBoxContainer/TechLevel
@onready var calc_params_box = $VBoxContainer/CalcParamsVBox
@onready var input_params_box = $VBoxContainer/InputParamsVBox
@onready var subcomps_box = $VBoxContainer/SubCompVBox

func _ready() -> void:
	#connect to value changed signals on all children? or only once on designer UI
	return

func update():
	#called from parent component, or designer UI if top level
	#ensure inputs are up to date, then update all subcomponents, then recalc all calc_params
	pass

func fetch_data(new_id, new_path=db_path):
	pattern_id = new_id
	db_path = new_path
	var db = SQLite.new()
	db.set_path(db_path)
	db.open_db()
	var data = db.select_rows(
		"calculated_parameters",
		"ID = "+str(new_id),
		["*"]
	)
	data = data[0] #error check for multiple rows?
	
	name_label.text = data["name"]
	type_label.text = data["type"]
	tl_label.text = data["tech_level"]
	
	var calc_param_ids = []
	var input_param_ids = []
	var subcomp_ids = []
	
	for i in range(0,10):
		if data["calc_param_"+str(i)]:
			calc_param_ids.add(data["calc_param_"+str(i)])
		if data["input_param_"+str(i)]:
			input_param_ids.add(data["input_param_"+str(i)])
		if data["sub_comp_"+str(i)]:
			subcomp_ids.add(data["sub_comp_"+str(i)])
	
	for id in calc_param_ids:
		var new_param = calc_scn.instantiate()
		calc_params_box.add_child(new_param)
		new_param.fetch_data(id, db_path)
	for id in input_param_ids:
		var new_param = input_scn.instantiate()
		input_params_box.add_child(new_param)
		new_param.fetch_data(id, db_path)
	for id in subcomp_ids:
		var new_param = input_scn.instantiate()
		subcomps_box.add_child(new_param)
		new_param.fetch_data(id, db_path)
	
	db.close_db()
