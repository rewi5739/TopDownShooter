extends Node

signal score_updated(health:String, exp:String, lvl:String)

var cur_exp: String = ""
var cur_lvl: String = ""
var cur_health: String = ""


func set_health(num: String):
	cur_health = num
	score_updated.emit(cur_health, cur_exp, cur_lvl)

func set_exp(num: String):
	#print("set exp called")
	cur_exp = num
	score_updated.emit(cur_health, cur_exp, cur_lvl)

func set_lvl(num: String):
	cur_lvl = num
	score_updated.emit(cur_health, cur_exp, cur_lvl)

func game_over():
	#use this to end the game
	get_tree().quit()
	pass
