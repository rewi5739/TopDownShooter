extends CharacterStateMachine

@export var projectile_scene : Resource #can also preload the thing using file path
@export var move_speed : float = 150
var large_fired: bool = false
var direction = 2
var req_exp = [0, 4, 16]
var level : int = 0
var experience : int = 0
var width = 7
var health = 0


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		#only shoot on left click pressed down
		if (event.button_index==1 and event.is_pressed()):
			#print("why no spam")
			var new_projectile = projectile_scene.instantiate()
			new_projectile.set_damage(1)
			get_parent().add_child(new_projectile)
			var projectile_forward = Vector2.from_angle(rotation)
			new_projectile.fire(projectile_forward, 700, 0)
			new_projectile.position = $Weapon/ProjectilePoint.global_position
			new_projectile.parent = self
		if (event.button_index==2 and event.is_pressed() and (not large_fired) and level >= 1):
			var new_projectile = projectile_scene.instantiate()
			new_projectile.set_damage(3)
			get_parent().add_child(new_projectile)
			var projectile_forward = position.direction_to(get_global_mouse_position())
			new_projectile.fire(projectile_forward, 200, 1)
			new_projectile.position = $Weapon/ProjectilePoint.global_position
			new_projectile.parent = self
			large_fired = true
	if event.is_action_pressed("TODO_Fix_this_action___________________________________________"):
		experience += 1
		check_level()

func _physics_process(delta: float) -> void:
	#look_at(get_viewport().get_mouse_position())
	
	#aiming logic, may not be used:
	$Weapon.rotation = position.direction_to(get_global_mouse_position()).angle()
	$Weapon/Sprite2D.flip_v = ($Weapon.rotation < -PI/2 or $Weapon.rotation > PI/2)
	#end of aim
	
	#vector comes in normalized
	velocity = Input.get_vector("move_left", "move_right", \
								"move_up", "move_down") * move_speed
	move_and_slide()
	
	#math to sort out direction in animation
	var angle = rad_to_deg(velocity.angle()) + 180
	
	match level:
		0:
			if (velocity.length() < 10):
				$AnimationPlayer.play("0_idle")
			else:
				if (angle > 130 and angle < 230):
					$AnimationPlayer.play("0_right")
					direction = 2
				if (angle > 230 and angle < 310):
					$AnimationPlayer.play("0_front")
					direction = 3
				if (angle > 310 or angle < 50):
					$AnimationPlayer.play("0_left")
					direction = 0
				if (angle > 50 and angle < 130):
					#print("Fix up animation")
					$AnimationPlayer.play("0_front")
					direction = 1
		1:
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
		2:
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

func collectable_collected(amount: int):
	#print("Player script recieved collectable call")
	experience += amount
	check_level()

func check_level():
	if level < 2:
		if experience >= req_exp[level+1]:
			level += 1
			experience = 0
			update_hitbox()
		print("check level to score manager" + str(experience) + str(level))
		ScoreManager.set_exp(str(experience) +"/"+ str(req_exp[level+1]))
		ScoreManager.set_lvl(str(level))
	else:
		ScoreManager.set_exp(str(experience))
		
func update_hitbox():
	var collider = get_node("MainCollider")
	match level:
		0:
			collider.shape.size = Vector2(7,7)
			width = 7
		1:
			collider.shape.size = Vector2(15,15)
			width = 15
		2:
			collider.shape.size = Vector2(30,30)
			width = 30
