extends State

@export var chase_speed : float = 50.0
var detect_range : Area2D
var target : CharacterBody2D
var running_state: State

func initialize():
	#print("helo")
	running_state = get_parent().get_node("Running")
	detect_range = body.get_node("DetectionRange")

func process_state(delta: float):
	#print("chasing state running")
	
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	
	var potential_targets = detect_range.get_overlapping_areas()
	if (not potential_targets.is_empty()):
		if potential_targets[0] is Area2D:
			#print("something")
			running_state.target = potential_targets[0]
			change_state.emit(running_state)
