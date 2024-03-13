extends CanvasLayer

signal game_start

func _on_start_pressed():
	self.set_visible(false)
	$MainTheme.stop()
	game_start.emit()
