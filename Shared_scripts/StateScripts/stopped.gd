extends State

var detect_range: Area2D
var spawning_state : State

func timer_action():
	#print("in stopped State")
	var body_list = detect_range.get_overlapping_bodies()
	var adjustment = 0
	for body in body_list:
		if body is TileMap:
			adjustment = -1
	if body_list.size() + adjustment < 3:
		change_state.emit(spawning_state)


func initialize():
	detect_range = body.get_node("DetectionRange")
	spawning_state = get_parent().get_node("Spawning")


func on_enter_state():
	body.play_animation("fire_start")

func on_exit_state():
	body.play_animation("fire_idle")

func process_state(delta : float):
	pass

func process_input(event: InputEvent):
	pass
