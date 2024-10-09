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

func play_animation(anim_name: String):
	$AnimationPlayer.play(anim_name)

func _on_timer_timeout() -> void:
	current_state.timer_action()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name.contains("start")):
		play_animation("fire_on")
