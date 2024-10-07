extends CharacterStateMachine
class_name Enemy

@export var hp : int = 3
@export var attack_sfx : Resource
@export var death_sfx : Resource
var Collectable = preload("res://collectable.tscn")
var direction:int = 0

signal attack(damage:int)


func hit(damage_number : int):
	hp -= damage_number
	if (hp <= 0):
		#add somehting for state machine if neciscary
		generate_loot()
		GlobalAudioManager.play_sfx(death_sfx)
		queue_free()

func generate_loot():
	#print("generate loot is run")
	var experience_box = Collectable.instantiate()
	experience_box.position = position
	get_parent().call_deferred("add_child", experience_box)
	#print(get_parent())

func update_animation():
	
	var angle = rad_to_deg(velocity.angle()) + 180
	
	if (velocity.length() < 10):
		match direction:
			0:
				$AnimationPlayer.play("enemy_idle_left")
			1:
				$AnimationPlayer.play("enemy_idle_up")
			2:
				$AnimationPlayer.play("enemy_idle_right")
				#print("playing enemy idle right")
			3:
				$AnimationPlayer.play("enemy_idle")
	else:
		if (angle > 130 and angle < 230):
			$AnimationPlayer.play("enemy_run_right")
			direction = 2
		if (angle > 230 and angle < 310):
			$AnimationPlayer.play("enemy_run_front")
			direction = 3
		if (angle > 310 or angle < 50):
			$AnimationPlayer.play("enemy_run_left")
			direction = 0
		if (angle > 50 and angle < 130):
			#print("Fix up animation")
			$AnimationPlayer.play("enemy_run_up")
			direction = 1

func attack_animation():
	var dirList = ["left", "up", "right", "front"]
	$AnimationPlayer.play("enemy_attack_" + dirList[direction])
	GlobalAudioManager.play_sfx(attack_sfx)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.contains("attack"):
		current_state._finish_attack()
