extends CharacterBody2D

var hp: = 10
var atk: = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	# Eventually create enums to randomly select from for speed
	self.set_velocity(Vector2(0,randi_range(25,80)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	if hp <= 0:
		queue_free()


func _on_hitbox_body_entered(body):
	hp -= body.get_atk()
	# Delete the bullet. Change this later when doing other 
	# Bullets so bullets handle their own freeing
	body.queue_free()
