extends AudioStreamPlayer2D

var current_track_name : String = ""
#var current_music_track : AudioStream

func play_track(new_stream : AudioStream, volume: = 0.5):
	if (stream == new_stream):
		return
	
	stream = new_stream
	volume_db = volume
	play()

func play_sfx(new_stream : AudioStream, volume = 0.5):
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = new_stream
	sfx_player.volume_db = volume
	sfx_player.name = "SFX_Instance"
	add_child(sfx_player)
	sfx_player.play()
	
	#gets called every frame trying to get the signal
	await sfx_player.finished
	sfx_player.queue_free()
