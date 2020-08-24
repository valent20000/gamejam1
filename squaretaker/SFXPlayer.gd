extends AudioStreamPlayer

export var sounds = []

func play_random():
	set_stream(sounds[randi()%sounds.size()])
	play()
