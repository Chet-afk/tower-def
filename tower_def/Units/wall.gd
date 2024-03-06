extends StaticBody2D

var hp: int


func _init():
	hp = 1000

func take_damage(dmg: int):
	hp -= dmg
	if hp <= 0:
		# Pause the game
		get_tree().paused = true
