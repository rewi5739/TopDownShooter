extends CharacterStateMachine
class_name EnemySpawner

@export var hp : int = 10
var Collectable = preload("res://collectable.tscn")

func hit(damage_number : int):
	hp -= damage_number
	if (hp <= 0):
		#add somehting for state machine if neciscary
		generate_loot()
		queue_free()

func generate_loot():
	#print("generate loot is run")
	var experience_box = Collectable.instantiate()
	experience_box.position = position
	get_parent().call_deferred("add_child", experience_box)
	#print(get_parent())



func _on_timer_timeout() -> void:
	current_state.timer_action()
