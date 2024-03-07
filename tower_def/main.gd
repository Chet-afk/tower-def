extends Node

@export var enemies: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var tower_spawns = get_tree().get_nodes_in_group("tower_spawner")
	for spawner in tower_spawns:
		spawner.spawned_unit.connect(_on_unit_spawned)

func _on_mob_spawn_timeout():
	# Create new mob and the spawner location
	var new_enemy = enemies.instantiate()
	var spawner = $SpawnPath/Spawner
	# Random location across the path
	spawner.progress_ratio = randf()
	
	new_enemy.position = spawner.position
	
	add_child(new_enemy)
	
func _on_unit_spawned(unit: player_unit_base):
	# When a tower spawner spawns a unit
	# Connect that units being_held signal here
	unit.holding.connect(_reveal_sell)

func _reveal_sell():
	# Show / Hide the trash when a tower is picked up / dropped
	$PlayerLayer/Trash.set_visible(not $PlayerLayer/Trash.is_visible())
	
	
