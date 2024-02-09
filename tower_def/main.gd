extends Node

@export var enemies: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_spawn_timeout():
	# Create new mob and the spawner location
	var new_enemy = enemies.instantiate()
	var spawner = $SpawnPath/Spawner
	# Random location across the path
	spawner.progress_ratio = randf()
	
	new_enemy.position = spawner.position
	
	add_child(new_enemy)
	
	
	
	
	
