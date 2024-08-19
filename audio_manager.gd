extends Node2D

var audio_players = {}
var music_player: AudioStreamPlayer
var bkgnd_music_options = [
	preload("res://music/main_background_808s_0.mp3"),
	preload("res://music/main_background_bassy_0.mp3")
]
var is_muted := false


func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.finished.connect(self.start_bkgnd_music)
	add_child(music_player)
	self.start_bkgnd_music()
	self.process_mode = Node.PROCESS_MODE_ALWAYS  # Prevent weird audio stuff with pausing

func play_sound(sound_name: String, volume_db: float = 0.0):
	if self.is_muted:
		return
	if sound_name in audio_players:
		audio_players[sound_name].play()
	else:
		var player = AudioStreamPlayer.new()
		player.stream = load("res://assets/Sounds/" + sound_name + ".wav")
		player.volume_db = volume_db
		add_child(player)
		audio_players[sound_name] = player
		player.play()
		
		
func play_music(music_name: String, volume_db: float = 0.0):
	music_player.stream = load("res://assets/Sounds/" + music_name + ".ogg")
	music_player.volume_db = volume_db
	music_player.play()

func start_bkgnd_music():
	# Play a random sound from the music options
	music_player.stream = bkgnd_music_options[randi() % len(bkgnd_music_options)]
	music_player.play()

func pause_music(to_pause: bool):
	music_player.stream_paused = to_pause

func mute(to_mute: bool):
	self.is_muted = to_mute
	self.pause_music(to_mute)

func set_master_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

func get_master_volume() -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
