extends Button

@export var unit: PackedScene


func _on_button_up():
	var placers = get_tree().get_nodes_in_group("placement_node")
	
	for each_placer in placers:
		if not each_placer.is_holding():
			var new_unit:player_unit_base = unit.instantiate()
			new_unit.set_placer(each_placer)
			new_unit.set_global_position(each_placer.get_global_position())
			each_placer.set_unit(new_unit)
			get_parent().add_child(new_unit)
			return