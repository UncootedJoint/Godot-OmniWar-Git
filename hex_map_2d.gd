class_name HexMap2D extends Node2D

@onready var scenario:ScenarioManager = $/root/ScenarioManager
@onready var tile_scn = load("res://../hex_tile_2d.tscn")
@onready var parent_scn = load("res://parent_hex_tile_2d.tscn")

var db

var origin:HexVector2D
var map_scale:int
@onready var map_mutex = Mutex.new()

var load_queue = []
var queue_task_id:int
enum HEXQ{
	BUILD,
	KEEP,
	FREE
}

func _init(start_coords:HexVector2D,start_scale:int) -> void:
	origin = start_coords
	map_scale = start_scale

func _ready() -> void:
	db = SQLite.new()
	db.path = scenario.file_path + "/hex_map_test.db"
	db.open_db()
	
	scenario.connect("scenario_map_zoomed_in", _on_scenario_map_zoomed_in)
	scenario.connect("scenario_map_zoomed_out", _on_scenario_map_zoomed_out)
	scenario.connect("scenario_map_panned", _on_scenario_map_panned)
	populate_hexes_simple()

func _on_scenario_map_zoomed_in():
	map_mutex.lock()
	map_scale = map_scale / 10
	origin = HexVector2D.new(origin.q*10,origin.r*10,origin.a*10).as_int()
	populate_hexes_simple()
	map_mutex.unlock()

func _on_scenario_map_zoomed_out():
	map_mutex.lock()
	map_scale = map_scale * 10
	origin = HexVector2D.new(origin.q/10,origin.r/10,origin.a/10).as_int()
	populate_hexes_simple()
	map_mutex.unlock()

func _on_scenario_map_panned(offset:HexVector2D):
	map_mutex.lock()
	origin = origin.add(offset).as_int()
	populate_hexes_simple()
	map_mutex.unlock()

func populate_hexes() -> void:
	print(str(origin.q) + ", " + str(origin.r))
	
	var test_coords:Array[HexVector2D] = origin.get_coords_in_radius(20)
	load_queue = []
	for i in test_coords.size():
		load_queue.append([test_coords[i],HEXQ.BUILD])
		for node in get_children():
			if is_equal_approx(node.local_coords.q,test_coords[i].q) and is_equal_approx(node.local_coords.r,test_coords[i].r):
				load_queue[i][1] = HEXQ.KEEP
			else:
				load_queue.append([node,HEXQ.FREE])
		match load_queue[i][1]:
			HEXQ.BUILD:
				var new_tile = tile_scn.instantiate()
				self.add_child(new_tile)
				new_tile.setup(load_queue[i][0].as_int(),self)
			HEXQ.KEEP:
				continue
			HEXQ.FREE:
				load_queue[i][0].queue_free()
		
		if fmod(test_coords[i].q,10.0) == 0 and fmod(test_coords[i].r,10.0) == 0:
			var parent_tile = parent_scn.instantiate()
			add_child(parent_tile)
			parent_tile.setup(test_coords[i].as_int(), origin.as_int())

func populate_hexes_simple():
	for node in get_children():
		node.queue_free()
	for coords in origin.get_coords_in_radius(25):
		var new_tile = tile_scn.instantiate()
		self.add_child(new_tile)
		new_tile.setup(coords,self)
		if fmod(coords.q,10.0) == 0 and fmod(coords.r,10.0) == 0:
			var parent_tile = parent_scn.instantiate()
			add_child(parent_tile)
			parent_tile.setup(coords, origin)
		

func populate_hexes_threaded() -> void:
	print(str(origin.q) + ", " + str(origin.r))
	if queue_task_id != null:
		WorkerThreadPool.wait_for_group_task_completion(queue_task_id)
	var test_coords:Array[HexVector2D] = origin.get_coords_in_radius(2)
	load_queue = []
	for i in test_coords.size():
		load_queue.append([test_coords[i],HEXQ.BUILD])
		for node in get_children():
			if node.local_coords.q == test_coords[i].q and node.local_coords.r == test_coords[i].r:
				load_queue[i][1] = HEXQ.KEEP
			else:
				load_queue.append([node,HEXQ.FREE])
		
		
		if fmod(test_coords[i].q,10.0) == 0 and fmod(test_coords[i].r,10.0) == 0:
			var parent_tile = parent_scn.instantiate()
			add_child(parent_tile)
			parent_tile.setup(test_coords[i], origin)
	
	queue_task_id = WorkerThreadPool.add_group_task(build_tile,load_queue.size(),1)

func build_tile(i):
	map_mutex.lock()
	match load_queue[i][1]:
		HEXQ.BUILD:
			var new_tile = tile_scn.instantiate()
			self.add_child.call_deferred(new_tile)
			new_tile.call_deferred("setup",load_queue[i][0],self)
		HEXQ.KEEP:
			return
		HEXQ.FREE:
			load_queue[i][0].queue_free()
			load_queue[i][1] = HEXQ.KEEP
	map_mutex.unlock()
