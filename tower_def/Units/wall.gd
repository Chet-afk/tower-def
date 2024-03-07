extends StaticBody2D

var cur_hp: int
var max_hp: int

func _init():
	cur_hp = 1000
	max_hp = 1000

func _ready():
	$HPBar.set_max(max_hp)
	$HPBar.set_value(max_hp)
	$HPBar/HPNum.set_text(str(max_hp) + " / " + str(max_hp))

func take_damage(dmg: int):
	cur_hp -= dmg
	$HPBar.value -= dmg
	$HPBar/HPNum.set_text(str(cur_hp) + " / " + str(max_hp))
	if cur_hp <= 0:
		# Pause the game
		get_tree().paused = true
