extends Area2D

var experience = 1
@export var collect_sfx: Resource


func _on_body_entered(body: Node2D) -> void:
	print("Collectable Body Entered")
	body.collectable_collected(experience)
	GlobalAudioManager.play_sfx(collect_sfx)
	queue_free()
