extends Node2D
class_name Placer
var unit: player_unit_base = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_holding():
	return unit != null

func set_unit(tower: player_unit_base):
	unit = tower
