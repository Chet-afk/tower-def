extends base_unit
class_name player_unit_base

@export var attack_scene: PackedScene

# Movement Related
var prev_position: Vector2
var being_held: bool = false
var clickable: bool = false
var in_placeable_area: bool = false
var snappable_area
var first_spawn: bool = true

# If the unit is able to attack or not
var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse") and clickable:
		being_held = true
		active = false
	elif being_held and Input.is_action_pressed("mouse"):
		# Follow the cursor so long as its pressed
		self.set_global_position(get_viewport().get_mouse_position())
		
	if Input.is_action_just_released("mouse") and being_held:
		self.update_position()

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

func update_position():
	if first_spawn and not in_placeable_area:
		queue_free()
	else:
		first_spawn = false
		being_held = false
		active = true
		# Snap to new area, or to previous one
		if in_placeable_area:
			self.set_global_position(snappable_area.get_global_position())
			prev_position = snappable_area.get_global_position()
		else:
			self.set_global_position(prev_position)


func _on_attack_timer_timeout():
	# Create the attack
	if not active:
		return
	var attack = attack_scene.instantiate()
	attack.set_position(self.get_position())
	# attach the bullets to the viewport 
	# otherwise will follow this tower node if moved
	get_parent().add_child(attack)

