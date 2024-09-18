extends State

var detect_range: Area2D
var chasing_state: State

func initialize():
	detect_range = body.get_node("DetectionRange")
	chasing_state = get_parent().get_node("Chasing")

func process_state(delta: float):
	#print("idle state running")
	var potential_targets = detect_range.get_overlapping_bodies()
	if (not potential_targets.is_empty()):
		print(potential_targets)
		chasing_state.target = potential_targets[0] as CharacterBody2D
		change_state.emit(chasing_state)
