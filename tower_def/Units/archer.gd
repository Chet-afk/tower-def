extends player_unit_base

func _ready():
	self.set_atk(100)

func create_attack():
	var attack = attack_scene.instantiate()
	attack.set_atk(self.get_atk())
	attack.set_position(self.get_global_position())
	attack.set_target(enemy_to_target)
	var degree_rotation = attack.get_rotation_degrees()
	get_parent().add_child(attack)
	
	for i in range(10):
		# Create one shot timer to space out shots
		await get_tree().create_timer(0.1).timeout
		attack = attack_scene.instantiate()
		attack.set_atk(self.get_atk())
		attack.set_position(self.get_global_position())
		var spread = Vector2(randf_range(-40,40), randf_range(-40,40))
		attack.set_target(enemy_to_target + spread)
		get_parent().add_child(attack)
