extends State

@export var chase_speed : float = 50.0
var detect_range : Area2D
var target : Area2D
var idle_state: State

func initialize():
	#print("helo")
	idle_state = get_parent().get_node("Idle")
	detect_range = body.get_node("DetectionRange")

func process_state(delta: float):
	#print("chasing state running")
	var potential_targets = detect_range.get_overlapping_areas()
	if (potential_targets.is_empty()):
		change_state.emit(idle_state)
		return
	
	if not is_instance_valid(target):
		target = potential_targets[0]
	
	body.velocity = -(target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	
	body.update_animation()
	
