extends State

var direction : int
var chasing_state : State

func initialize():
	chasing_state = get_parent().get_node("Chasing")

func on_enter_state():
	#print("entered atacking state")
	body.attack_animation()

func on_exit_state():
	pass

func process_state(delta : float):
	pass

func process_input(event: InputEvent):
	pass

func _finish_attack():
	change_state.emit(chasing_state)
