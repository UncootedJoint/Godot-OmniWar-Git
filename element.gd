extends Node
class_name Element

@export var designation:String
@export var display_name:String
@export var short_name:String

@export var initial_position:Array[float] = [0.0,0.0]
var position = HexVector2D.new(initial_position[0], initial_position[1])
