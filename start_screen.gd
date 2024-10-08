extends CanvasLayer



func _on_start_button_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index==1 and event.is_pressed()):
			get_tree().change_scene_to_file("res://main.tscn")
