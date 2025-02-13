class_name ComponentPattern extends PanelContainer

@export var pattern_id:int
@export var db_path:String = "res://database/universe_test.db"

func _ready() -> void:
	#connect to value changed signals on all children? or only once on designer UI
	return

func update():
	#called from parent component, or designer UI if top level
	#ensure inputs are up to date, then update all subcomponents, then recalc all calc_params
	pass

func fetch_data(new_id):
	pattern_id = new_id
	var db = SQLite.new()
	db.set_path(db_path)
	db.open_db()
	
	
	
	db.close_db()
