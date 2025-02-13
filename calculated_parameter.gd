class_name CalcParameter extends PanelContainer

@export var param_id:int
@export var db_path:String = "res://database/universe_test.db"

@export var equation:String
@export var input1:float
@export var input2:float
@export var constant:float

var value:float = 0.

func _ready() -> void:
	pass

func calculate():
	match equation:
		"ADD":
			value = input1 + input2
		"SUBTRACT": 
			value = input1 - input2
		#etc.
		
		"PASS":
			value = input1
		"CONSTANT":
			value = constant

func fetch_data(id):
	var db = SQLite.new()
	db.set_path(db_path)
	db.open_db()
	var data = db.select_rows(
		"calculated_parameters",
		"ID = "+str(id),
		["*"]
	)
	equation = data.equation
	constant = data.constant
	
	if data.input1 == "constant":
		input1 = constant
	elif not data.input1.has(","):
		for param in get_parent().get_children():
			if param.name == data.input1:
				input1 = param.value
	else:
		for sub in get_parent().get_children():
			if sub.name == data.input1.get_slice(",",0):
				for param in sub.get_children():
					if param.name == data.input.get_slice(",",1):
						input1 = param.value
	
	if data.input2 == "constant":
		input2 = constant
	elif not data.input2.has(","):
		for param in get_parent().get_children():
			if param.name == data.input2:
				input2 = param.value
	else:
		for sub in get_parent().get_children():
			if sub.name == data.input2.get_slice(",",0):
				for param in sub.get_children():
					if param.name == data.input.get_slice(",",1):
						input2 = param.value
	
	db.close_db()
