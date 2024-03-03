extends CharacterBody2D
class_name player_unit_base

@export var attack_scene: PackedScene
var attack
var atk_speed: float
var atk: int = 0
var range: float

# Movement Related
var placer_node: Placer
var being_held: bool = false
var clickable: bool = false
var in_placeable_area: bool = false
var snappable_area: Area2D

# If the unit is able to attack or not
var active: bool = false

var enemies_in_range: Array[Node2D] = []
var enemy_to_target: = Vector2(0,0)

# Getters
func get_atk_speed() -> float:
	return(atk_speed)
func get_atk() -> int:
	return(atk)
func get_range() -> float:
	return($Detection/DetectionArea.get_radius())
func get_prev_node() -> Placer:
	return(placer_node)

# Setters
func set_atk_speed(value: float):
	atk_speed = value
func set_atk(value: int):
	atk = value
func set_range(value: float):
	$Detection/DetectionArea.set_radius(value)
func set_placer(placement: Placer):
	placer_node = placement
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This section checks for movement
	if Input.is_action_just_pressed("mouse") and clickable:
		being_held = true
	elif being_held and Input.is_action_pressed("mouse"):
		# Follow the cursor so long as its pressed
		self.set_global_position(get_viewport().get_mouse_position())
	if Input.is_action_just_released("mouse") and being_held:
		self.update_position()

	# Constant check for entering enemies into range
	if not being_held and $Detection.has_overlapping_bodies():
		active = true
		enemies_in_range = $Detection.get_overlapping_bodies()
		find_target()
	else:
		active = false

# Signals section

# Determine if the sprite should be clickable or not based off cursor
func _on_snap_position_mouse_entered():
	clickable = true

func _on_snap_position_mouse_exited():
	clickable = false

# Check to see if unit is in snappable area
func _on_snap_position_area_entered(area):
	# Placers group is in the placement node
	if area.is_in_group("placers"):
		snappable_area = area
		in_placeable_area = true

func _on_snap_position_area_exited(area):
	if area.is_in_group("placers"):
		in_placeable_area = false

func _on_attack_timer_timeout():
	# Create the attack
	if active:
		create_attack()


# Helpers
func update_position():
	being_held = false
	active = true
	# Snap to new area, or to previous one
	if in_placeable_area:
		var new_placer = snappable_area.get_parent()
		self.set_global_position(new_placer.get_global_position())
		
		# swap the towers
		if new_placer.is_holding():
			# Set the new placement values to the unit
			var swap_unit = new_placer.unit
			swap_unit.set_global_position(placer_node.get_global_position())
			swap_unit.set_placer(self.placer_node)
			placer_node.set_unit(swap_unit)
		else:
			# Reset to null for old placer
			placer_node.set_unit(null)
		placer_node = new_placer
		placer_node.set_unit(self)

	else:
		self.set_global_position(placer_node.get_global_position())

func find_target():
	# find the unit closest to bottom
	if enemies_in_range.is_empty():
		return
	
	var lowest : Vector2 = Vector2(0,0)
	for enemy in enemies_in_range:
		if lowest.y < enemy.position.y:
			lowest = enemy.position
	enemy_to_target = lowest

func create_attack():
	# Each inherited unit will create its own attack
	pass



