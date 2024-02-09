extends Node2D
class_name base_unit

# Functionality
var prev_position: Vector2
var being_held: bool = false
var clickable: bool = false
var active: bool = false

# Statistics
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
		being_held = false
		active = true
		# Uncomment this later once prev position is configured
		#self.set_global_position(prev_position)
	

# Determine if the sprite should be clickable or not based off cursor
func _on_snap_position_mouse_entered():
	clickable = true
func _on_snap_position_mouse_exited():
	clickable = false

# Setters
func set_prev_pos(position:Vector2):
	pass

