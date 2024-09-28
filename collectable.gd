extends Area2D

var experience = 1



func _on_body_entered(body: Node2D) -> void:
	print("Collectable Body Entered")
	body.collectable_collected(experience)
	queue_free()
