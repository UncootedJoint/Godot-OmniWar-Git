class_name HexVector2D extends Node

var q:float
var r:float
var a:float

func _init(new_q :float, new_r :float, new_a:=0.0):
	q = new_q
	r = new_r
	a = new_a

func add(added :HexVector2D):
	return HexVector2D.new(self.q + added.q, self.r + added.r, self.a + added.a)

func subtract(subtracted :HexVector2D):
	return HexVector2D.new(self.q - subtracted.q, self.r - subtracted.r, self.a - subtracted.a)

func scale(factor:float = 1.0) -> HexVector2D:
	var scaled_vector = HexVector2D.new(self.q * factor, self.r * factor, self.a * factor)
	return scaled_vector

func scale_in_place(factor:float = 1.0) -> HexVector2D:
	self.q = self.q * factor
	self.r = self.r * factor
	self.a = self.a * factor
	return self

func offset(offset_in:HexVector2D, factor:int = 1) -> HexVector2D:
	var offset_vec = offset_in.scale(factor)
	self.subtract(offset_vec)
	return self

func magnitude_2d(vector : HexVector2D = self) -> float:
	if vector.q * vector.r <= 0:
		return abs(vector.q) + abs(vector.r)
	elif vector.q * vector.r > 0:
		return max(abs(vector.q), abs(vector.r))
	else:
		return 0

func magnitude_3d(vector : HexVector2D = self) -> float:
	var vec2 = Vector2(vector.magnitude_2d(), vector.a)
	return round(vec2.length())

func clamp_by_mag2d(limit:float, vector:HexVector2D = self):
	var mag = vector.magnitude_2d()
	vector.q = vector.q * (limit/mag)
	vector.r = vector.r * (limit/mag)
	return

func clamp_by_mag3d(limit:float, vector:HexVector2D = self):
	var mag = vector.magnitude_3d()
	vector.scale_in_place(limit/mag)
	return

func vector_to(vector : HexVector2D) -> HexVector2D:
	return self.subtract(vector)

func dist_between(target, start = self):
	var vector = start.subtract(target)
	return vector.magnitude_3d()

func get_coords_in_radius(radius:int,center:HexVector2D=self) -> Array[HexVector2D]:
	var result_coords:Array[HexVector2D] = []
	for q in range(center.q-radius,center.q+radius+1):
		for r in range(center.r-radius,center.r+radius+1):
			var test_vect = HexVector2D.new(q,r)
			if test_vect.magnitude_2d(test_vect.subtract(center)) <= radius:
				result_coords.append(test_vect)
	return result_coords

func bearing(vector : HexVector2D):
	pass
	
func hex_to_cartesian(hex:HexVector2D = self, pixel_spacing = 1) -> Vector2:
	var hex_s = hex.q + hex.r
	var hex_q = hex.q - hex_s
	var hex_r = hex.r - hex_s - hex_q
	var cart_x = pixel_spacing * (sqrt(3.0)/2 * hex_s) + (sqrt(3.0)/2 * hex_r)
	var cart_y = pixel_spacing * (1.5 * hex_r)
	var cartesian:Vector2 = Vector2(cart_x, cart_y)
	return cartesian

static func cartesian_to_hex(cart:Vector2, pixel_spacing) -> HexVector2D:
	#this can't be right
	#though it seems like it is?
	var hex_s = (sqrt(3)/3 * cart.x - 1.0/3 * cart.y)/pixel_spacing
	var hex_r = (2.0/3 * cart.y)/pixel_spacing + hex_s
	var hex_q = hex_s
	var hex = HexVector2D.new(hex_q, hex_r)
	return hex
