extends CharacterBody2D

var damage_label: PackedScene = preload("res://UI/damage_text.tscn")
var hp: = 10
var atk: = 10
# Check to ensure node does not queue free
# before actually spawning
var active: bool = false 

var prev_position: Vector2
var vel: Vector2
# Direction is a multiplier to go up or down
# Depending on how enemy collides with placement shape
var direction: int
var nodes_global_pos: Vector2
var at_wall: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Eventually create enums to randomly select from for speed
	vel = Vector2(randi_range(-25,-80),0)
	self.set_velocity(vel)
	self.hp = randi_range(100,500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision: bool = move_and_slide()
	if hp <= 0:
		queue_free()
	
	if collision and $AttackTimer.is_stopped():
		if not get_slide_collision(0).get_collider() is Placer: 
			$AttackTimer.start()
		
	
	if ((prev_position - global_position).length() <= 0.2):
		# Direction = 1 : Go down, -1 : go up, 0 : don't move
		if global_position.y < nodes_global_pos.y:
			direction = -1
		elif global_position.y > nodes_global_pos.y:
			direction = 1
			
		if at_wall:
			direction = 0
		
		self.set_velocity(vel + (Vector2(0, 30) * Vector2(0, direction)))
		$VelocityTimer.start()
	
	prev_position = self.get_global_position()
	
func _on_hitbox_body_entered(body: base_attack):
	var dmg = body.get_atk()
	# Remove the attack unless its a persistent one
	if not body.get_pierceable():
		body.queue_free()
	
	hp -= dmg
	
	# Damage popup
	var dmg_text = damage_label.instantiate()
	dmg_text.set_text(str(dmg))
	dmg_text.set_global_position(self.get_global_position())
	get_parent().add_child(dmg_text)
	
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	if active:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	active = true


func _on_attack_timer_timeout():
	# Only activates when at the wall
	var target = get_slide_collision(0).get_collider()
	target.take_damage(atk)

func _reset_velocity():
	self.set_velocity(vel)


func _on_hitbox_area_entered(area: Area2D):

	if area.get_parent().is_in_group("placement_node"):
		nodes_global_pos = area.get_parent().get_global_position()
	# This check ensures its the wall , otherwise it triggers on enemies overlapping
	elif area.get_parent() is StaticBody2D:
		at_wall = true
