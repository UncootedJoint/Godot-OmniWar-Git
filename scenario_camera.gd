class_name ScenarioCamera extends Camera2D

signal camera_zoom_limit_in
signal camera_zoom_limit_out

@export var min_zoom = .2
@export var max_zoom = 3

var pan_speed = 50
var zoom_speed = Vector2(2,2)

func _process(delta: float) -> void:
	print(str(position) + str(zoom.x))

func _unhandled_input(event: InputEvent) -> void:
	var delta = self.get_process_delta_time()
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				self.position.y -= pan_speed * delta
			KEY_S:
				self.position.y += pan_speed * delta
			KEY_A:
				self.position.x -= pan_speed * delta
			KEY_D:
				self.position.x += pan_speed * delta
	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if zoom.x < max_zoom:
					zoom += zoom_speed * delta
				elif zoom.x >= max_zoom:
					pass
			MOUSE_BUTTON_WHEEL_DOWN:
				if zoom.x > min_zoom:
					zoom -= zoom_speed * delta
				elif zoom.x <= min_zoom:
					pass
