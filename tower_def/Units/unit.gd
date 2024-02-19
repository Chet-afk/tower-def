extends Node2D
class_name base_unit


var attack: base_attack
# Statistics
var atk_speed: float
var atk: int
var range: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Getters
func get_atk_speed() -> float:
	return(atk_speed)
func get_atk() -> int:
	return(atk)
func get_range() -> float:
	return($Detection/DetectionArea.get_radius())
	
# Setters
func set_atk_speed(value: float):
	atk_speed = value
func set_atk(value: int):
	atk = value
func set_range(value: float):
	$Detection/DetectionArea.set_radius(value)




# Begin attacking if enemy body is in the detection area
func _on_detection_body_entered(body):
	pass # Replace with function body.
