extends State

var detect_range: Area2D
var spawning_state : State

func timer_action():
	print("in stopped State")
	var body_list = detect_range.get_overlapping_bodies()
	if body_list.size() < 3:
		change_state.emit(spawning_state)


func initialize():
	detect_range = body.get_node("DetectionRange")
	spawning_state = get_parent().get_node("Spawning")


func on_enter_state():
	pass

func on_exit_state():
	pass

func process_state(delta : float):
	pass

func process_input(event: InputEvent):
	pass
