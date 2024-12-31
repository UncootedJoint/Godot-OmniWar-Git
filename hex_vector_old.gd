extends RefCounted
class_name HexVectorOld

func _init(new_q := 0.0, new_r := 0.0, new_s := 0.0):
	var q = new_q
	var r = new_r
	var s = new_s

func add(added :HexVector2D):
	return HexVector2D.new(self.q + added.q, self.r + added.r, self.s + added.s)

func subtract(subtracted :HexVector2D):
	return HexVector2D.new(self.q - subtracted.q, self.r - subtracted.r, self.s - subtracted.s)

func magnitude(vector : HexVector2D = self):
	return abs(vector.q) + abs(vector.r) + abs(vector.s) / 2

func dist_between(start, target):
	var vector = start.subtract(target)
	return vector.magnitude()

func bearing(vector : HexVector2D):
	pass
	
func constrain(vector:HexVector2D):
	var con_vec = HexVector2D.new()
	# implement logic here
	if con_vec.q + con_vec.r + con_vec.s == 0:
		return con_vec
