extends CanvasLayer

func update_score(experience : String, level):
	$Label.text = "Experience: " + experience + "\nLevel: " + str(level)
