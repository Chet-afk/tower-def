extends Node2D
class_name Placer
var unit: player_unit_base = null

func is_holding():
	return unit != null

func set_unit(tower: player_unit_base):
	unit = tower
