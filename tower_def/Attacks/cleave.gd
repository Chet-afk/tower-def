extends base_attack

func _init():
	speed = 0


func _on_free_timer_timeout():
	queue_free()
