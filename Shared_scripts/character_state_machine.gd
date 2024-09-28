extends CharacterBody2D
class_name CharacterStateMachine

@export var initial_state : State
@onready var current_state: State = initial_state

var all_states : Array[State]

func _ready() -> void:
	for child in $States.get_children():
		if (child is State):
			all_states.append(child)
			#connecting signal
			child.change_state.connect(on_change_state)
			child.body = self
			child.initialize()
		else:
			push_warning("Child " + child.name + " Is not a state for " + self.name)
	initialize()

func initialize():
	pass

func _physics_process(delta: float) -> void:
	current_state.process_state(delta)

func on_change_state(next_state: State):
	current_state.on_exit_state()
	current_state = next_state
	current_state.on_enter_state()
