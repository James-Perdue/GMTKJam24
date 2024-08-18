extends Node2D

var audio_players = {}
var music_player: AudioStreamPlayer2D

func _ready():
	music_player = AudioStreamPlayer2D.new()
	add_child(music_player)

func play_sound(sound_name: String, volume_db: float = 0.0):
	if sound_name in audio_players:
		audio_players[sound_name].play()
	else:
		var player = AudioStreamPlayer2D.new()
		player.stream = load("res://assets/Sounds/" + sound_name + ".wav")
		player.volume_db = volume_db
		add_child(player)
		audio_players[sound_name] = player
		player.play()

func play_music(music_name: String, volume_db: float = 0.0):
	music_player.stream = load("res://assets/Sounds/" + music_name + ".ogg")
	music_player.volume_db = volume_db
	music_player.play()

func stop_music():
	music_player.stop()

func set_master_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)
