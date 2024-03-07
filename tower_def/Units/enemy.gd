extends CharacterBody2D

var damage_label: PackedScene = preload("res://UI/damage_text.tscn")
var hp: = 10
var atk: = 10
# Check to ensure node does not queue free
# before actually spawning
var active: bool = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Eventually create enums to randomly select from for speed
	self.set_velocity(Vector2(randi_range(-25,-80),0))
	self.hp = randi_range(100,500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	if hp <= 0:
		queue_free()
	
	if get_slide_collision_count() and $AttackTimer.is_stopped():
		$AttackTimer.start()


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
	# Can assume theres only one collision, since this should only activate
	# when at the wall
	var target = get_slide_collision(0).get_collider()
	target.take_damage(atk)
