extends Node2D
class_name base_unit

# Movement Related
var prev_position = null
var being_held: bool = false
var clickable: bool = false
var in_placeable_area: bool = false
var snappable_area


# Statistics
var active: bool = false
var atk_speed: float
var atk: int
var range: float

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
		# Remove the tower if it hasn't been placed before
		if prev_position == null:
			queue_free()
		else:
			being_held = false
			active = true
			# Snap to new area, or to previous one
			if in_placeable_area:
				self.set_global_position(snappable_area.get_global_position())
				prev_position = snappable_area.get_global_position()
			else:
				self.set_global_position(prev_position)
	

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








