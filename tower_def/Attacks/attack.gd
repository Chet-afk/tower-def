extends CharacterBody2D
class_name base_attack

var atk: int = 0
var speed: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()

func set_atk(damage):
	atk = damage

func set_target(enemy_position: Vector2):
	self.look_at(enemy_position)
	var direction: Vector2 = enemy_position - self.position
	self.set_velocity(direction.normalized() * self.speed)

func get_atk() -> int:
	return(atk)



func _on_on_screen_check_screen_exited():
	queue_free()
