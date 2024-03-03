extends CharacterBody2D
class_name base_attack

@export var piercable: bool
var atk: int = 0
var speed: int = 0

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

func get_pierceable() -> bool:
	return(piercable)

func _on_on_screen_check_screen_exited():
	queue_free()
