extends CharacterBody2D

@export var projectile_scene : Resource #can also preload the thing using file path
@export var move_speed : float = 500
var largeFired: bool = false

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
		if (event.button_index==2 and event.is_pressed()):
			if not largeFired:
				#TODO: make the projectile fire once, then retreivable.
				var new_projectile = projectile_scene.instantiate()
				get_parent().add_child(new_projectile)
				var projectile_forward = Vector2.from_angle(rotation)
				new_projectile.fire(projectile_forward, 300, 1)
				new_projectile.position = $ProjectilePoint.global_position

func _physics_process(delta: float) -> void:
	look_at(get_viewport().get_mouse_position())
	
	#vector comes in normalized
	velocity = Input.get_vector("move_left", "move_right", \
								"move_up", "move_down") * move_speed
	move_and_slide()
