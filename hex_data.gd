class_name HexData extends Resource

@export var coords_q:int
@export var coords_r:int
@export var coords_a:int
@export var size:int

func _init(i_coords:HexVector2D = HexVector2D.new(0,0), i_size:int = 1) -> void:
	coords_q = i_coords.q
	coords_r = i_coords.r
	coords_a = i_coords.a
	size = i_size

#@export var parent_hex:HexData
#@export var neighbors:Array[HexData]
#@export var subhexes:Array[HexData]

#func get_neighbors() -> Array[HexData]:
	#var local_coords = HexVector2D.new(coords_q, coords_r)
	#for sibling in parent_hex.subhexes:
		#if neighbors.has(sibling) == false:
			#var sib_coords = HexVector2D.new(sibling.local_coords_q, sibling.local_coords_r)
			#if local_coords.dist_between(sib_coords) == 1:
				#neighbors.append(sibling)
	#return neighbors
