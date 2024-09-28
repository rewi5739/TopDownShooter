extends State

var detect_range: Area2D
var chasing_state: State
var running_state: State

func initialize():
	detect_range = body.get_node("DetectionRange")
	chasing_state = get_parent().get_node("Chasing")
	running_state = get_parent().get_node("Running")

func process_state(delta: float):
	#print("idle state running")
	var potential_targets = detect_range.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		#print(potential_targets)
		if potential_targets[0] is not Area2D:
			chasing_state.target = potential_targets[0] as CharacterBody2D
			change_state.emit(chasing_state)
	
	potential_targets = detect_range.get_overlapping_areas()
	if (not potential_targets.is_empty()):
		if potential_targets[0] is Area2D:
			#print("something")
			running_state.target = potential_targets[0]
			change_state.emit(running_state)
	
	body.velocity = body.velocity.normalized()
	body.update_animation()
