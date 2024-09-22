extends CharacterBody2D

@export var projectile_scene : Resource #can also preload the thing using file path
@export var move_speed : float = 300
var largeFired: bool = false
var direction = 2


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		#only shoot on left click pressed down
		if (event.button_index==1 and event.is_pressed()):
			#print("why no spam")
			var new_projectile = projectile_scene.instantiate()
			get_parent().add_child(new_projectile)
			var projectile_forward = Vector2.from_angle(rotation)
			new_projectile.fire(projectile_forward, 700, 0)
			new_projectile.position = $ProjectilePoint.global_position
			new_projectile.parent = self
		if (event.button_index==2 and event.is_pressed()):
			if not largeFired:
				#TODO: make the projectile fire once, then retreivable.
				var new_projectile = projectile_scene.instantiate()
				get_parent().add_child(new_projectile)
				
				var projectile_forward = position.direction_to(get_global_mouse_position())
				new_projectile.fire(projectile_forward, 200, 1)
				new_projectile.position = $ProjectilePoint.global_position
				new_projectile.parent = self
				largeFired = true

func _physics_process(delta: float) -> void:
	#look_at(get_viewport().get_mouse_position())
	
	#vector comes in normalized
	velocity = Input.get_vector("move_left", "move_right", \
								"move_up", "move_down") * move_speed
	move_and_slide()
	
	#math to sort out direction in animation
	var angle = rad_to_deg(velocity.angle()) + 180
	
	if (velocity.length() < 10):
		match direction:
			0:
				$AnimationPlayer.play("1_idle_left")
			1:
				$AnimationPlayer.play("1_idle_up")
			2:
				$AnimationPlayer.play("1_idle_right")
			3:
				$AnimationPlayer.play("1_idle_front")
	else:
		if (angle > 130 and angle < 230):
			$AnimationPlayer.play("1_walk_right")
			direction = 2
		if (angle > 230 and angle < 310):
			$AnimationPlayer.play("1_walk_front")
			direction = 3
		if (angle > 310 or angle < 50):
			$AnimationPlayer.play("1_walk_left")
			direction = 0
		if (angle > 50 and angle < 130):
			#print("Fix up animation")
			$AnimationPlayer.play("1_walk_up")
			direction = 1
	
