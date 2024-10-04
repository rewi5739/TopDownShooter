extends Node

@export var bg_music : Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudioManager.play_track(bg_music, 0.5)
