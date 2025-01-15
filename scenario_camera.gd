class_name ScenarioCamera extends Camera2D

signal camera_zoom_limit_in
signal camera_zoom_limit_out
signal camera_pan_limit(offset:HexVector2D)

@export var min_zoom = .1
@export var max_zoom = 2

var pan_speed = 500
var zoom_speed = Vector2(3,3)

func _process(delta: float) -> void:
	#print(str(position) + str(zoom.x))
	return

func _on_scenario_map_zoomed_in() -> void:
	zoom.x = max_zoom - (zoom.x - min_zoom)
	zoom.y = max_zoom - (zoom.y - min_zoom)

func _on_scenario_map_zoomed_out() -> void:
	zoom.x = min_zoom + (max_zoom - zoom.x)
	zoom.y = min_zoom + (max_zoom - zoom.y)

func _unhandled_input(event: InputEvent) -> void:
	var delta = self.get_process_delta_time()
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				self.position.y -= pan_speed * delta
				camera_pan()
			KEY_S:
				self.position.y += pan_speed * delta
				camera_pan()
			KEY_A:
				self.position.x -= pan_speed * delta
				camera_pan()
			KEY_D:
				self.position.x += pan_speed * delta
				camera_pan()
	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if zoom.x < max_zoom:
					zoom += zoom_speed * delta
				elif zoom.x >= max_zoom:
					camera_zoom_limit_in.emit()
			MOUSE_BUTTON_WHEEL_DOWN:
				if zoom.x > min_zoom:
					zoom -= zoom_speed * delta
				elif zoom.x <= min_zoom:
					camera_zoom_limit_out.emit()

func camera_pan():
	var vector_pos = HexVector2D.cartesian_to_hex(position, HexTile2D.pixel_spacing)
	print("vector: "+str(vector_pos.q) +", "+ str(vector_pos.r))
	if vector_pos.magnitude_2d() > 6:
		vector_pos.clamp_by_mag2d(6)
		camera_pan_limit.emit(vector_pos)
		vector_pos = HexVector2D.new(0,0,0).subtract(vector_pos)
		position = vector_pos.hex_to_cartesian()
