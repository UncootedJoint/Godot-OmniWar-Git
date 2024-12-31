class_name HexVector2D extends RefCounted

func _init(new_q :float, new_r :float, new_a:=0.0):
	var q = new_q
	var r = new_r
	var a = new_a

func add(added :HexVector2D):
	return HexVector2D.new(self.q + added.q, self.r + added.r, self.a + added.a)

func subtract(subtracted :HexVector2D):
	return HexVector2D.new(self.q - subtracted.q, self.r - subtracted.r, self.a - subtracted.a)

func magnitude_2d(vector : HexVector2D = self):
	if vector.q * vector.r <= 0:
		return abs(vector.q) + abs(vector.r)
	elif vector.q * vector.r > 0:
		return max(abs(vector.q), abs(vector.r))
		
func magnitude_3d(vector : HexVector2D = self):
	var vec2 = Vector2(self.magnitude_2d(), self.a)
	return vec2.length()

func dist_between(start, target):
	var vector = start.subtract(target)
	return vector.magnitude_3d()

func bearing(vector : HexVector2D):
	pass
	
