class_name HexVector2D extends RefCounted

func _init(new_q :float, new_r :float, new_a:=0.0):
	var q = new_q
	var r = new_r
	var a = new_a

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

func magnitude_2d(vector : HexVector2D = self) -> int:
	if vector.q * vector.r <= 0:
		return abs(vector.q) + abs(vector.r)
	elif vector.q * vector.r > 0:
		return max(abs(vector.q), abs(vector.r))
	else:
		return 0

func magnitude_3d(vector : HexVector2D = self) -> float:
	var vec2 = Vector2(vector.magnitude_2d(), vector.a)
	return round(vec2.length())

func vector_to(vector : HexVector2D) -> HexVector2D:
	return self.subtract(vector)

func dist_between(target, start = self):
	var vector = start.subtract(target)
	return vector.magnitude_3d()

func bearing(vector : HexVector2D):
	pass
	
func hex_to_cartesian(hex:HexVector2D = self, pixel_spacing = 1) -> Vector2:
	var hex_s = hex.q + hex.r
	var hex_q = hex.q - hex_s
	var hex_r = hex.r - hex_s - hex_q
	var cart_x = pixel_spacing * (sqrt(3) * hex_s + sqrt(3)/2 * hex_r)
	var cart_y = -pixel_spacing * (1.5 * hex_r)
	var cartesian:Vector2 = Vector2(cart_x, cart_y)
	return cartesian

func cartesian_to_hex(cart:Vector2, pixel_spacing) -> HexVector2D:
	var hex_s = (sqrt(3)/3 * cart.x - 1.0/3 * cart.y)/pixel_spacing
	var hex_r = (2.0/3 * cart.y)/pixel_spacing + hex_s
	var hex_q = hex_s
	var hex = HexVector2D.new(hex_q, hex_r)
	return hex
