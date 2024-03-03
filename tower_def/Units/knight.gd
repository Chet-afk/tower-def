extends player_unit_base

func _ready():
	self.set_atk(200)

func create_attack():
	attack = attack_scene.instantiate()
	attack.set_atk(self.get_atk())
	attack.set_position(self.get_global_position())
	attack.look_at(enemy_to_target)
	attack.set_target(enemy_to_target)
	# attach the bullets to the viewport 
	# otherwise will follow this tower node if moved
	get_parent().add_child(attack)
