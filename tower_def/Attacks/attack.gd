extends CharacterBody2D
class_name base_attack

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_velocity(Vector2(0,randi_range(25,80)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()


func _on_hitbox_area_entered(area):
	# clear self after hitting an enemy
	pass

func get_atk():
	return get_parent().get_atk()
