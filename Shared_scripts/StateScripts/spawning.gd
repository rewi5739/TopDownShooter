extends State

var detect_range: Area2D
var stopped_state : State
var enemy_scene = preload("res://actors/Enemies/basic_enemy.tscn")

func timer_action():
	#print("in spawning state")
	spawn_enemy()
	var body_list = detect_range.get_overlapping_bodies()
	var adjustment = 0
	for body in body_list:
		if body is TileMap:
			adjustment = -1
	if body_list.size() + adjustment > 3:
		change_state.emit(stopped_state)

func initialize():
	detect_range = body.get_node("DetectionRange")
	stopped_state = get_parent().get_node("Stopped")

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = body.position + Vector2((randf()- 0.5) * 100, (randf() - 0.5) * 100)
	body.get_parent().add_child(enemy)
