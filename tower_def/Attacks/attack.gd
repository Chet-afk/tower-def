extends CharacterBody2D
class_name base_attack

var atk: int 
# Called when the node enters the scene tree for the first time.
func _ready():
	# This needs to change to the enemy in question
	self.set_velocity(Vector2(randi_range(-100,80),randi_range(-100,80)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()

func set_atk(damage):
	atk = damage

func get_atk() -> int:
	return(atk)
