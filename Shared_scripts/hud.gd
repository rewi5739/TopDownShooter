extends CanvasLayer

func _ready() -> void:
	ScoreManager.score_updated.connect(_update_score)

func _update_score(health: String, experience : String, level: String):
	print("signal Recieved update score")
	#This is an example of how to make global signals and such. 
	var label_text = ""
	label_text += "Health: " + health + "\n"
	label_text += "Experience: " + experience + "\n"
	label_text += "Level: " + level + "\n"
	#print(label_text)
	
	$Label.text = label_text
