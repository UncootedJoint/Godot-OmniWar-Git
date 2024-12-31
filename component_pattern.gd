class_name ComponentPattern extends Resource

@export var display_name = ""
enum Shape {CUBE, CYLINDER, SPHERE}
@export var shape:Shape
@export var parameters:Array[ComponentParameter] = []
@export var subcomponents:Array[ComponentPattern] = []


#func update_stats(): 
	#for param in parameters:
		#if param.mass:
			#total_mass += param.mass
	#for comp in subcomponents:
		#total_mass += comp.total_mass
# this should be on the designer node?
