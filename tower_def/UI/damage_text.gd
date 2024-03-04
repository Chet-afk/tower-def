extends Label

func _on_remove_timer_timeout():
	queue_free()
