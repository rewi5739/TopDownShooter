extends Node

@export var bg_music : Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudioManager.play_track(bg_music)

func _process(delta: float) -> void:
	var children = get_children()
	var finished:bool = true
	for child in children:
		if child.name.contains("EnemySpawner"):
			finished = false
	if finished:
		get_tree().change_scene_to_file("res://end_screen.tscn")
