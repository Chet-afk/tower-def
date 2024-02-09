extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Eventually create enums to randomly select from for speed
	self.set_velocity(Vector2(0,randi_range(25,80)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
