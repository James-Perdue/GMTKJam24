extends TextureRect

# Switch screens
var main_game = preload("res://scenes/RootLevel.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.pause_music(true)
	$upgrade_grid/new_game/Button.pressed.connect(self._start_game)
	$upgrade_grid/controls/Button.pressed.connect(self._controls_screen)
	$upgrade_grid/leaderboard/Button.pressed.connect(self._leaderboard)
	$CanvasLayer/controls.hide()
	$CanvasLayer/controls.exit_c.connect(self._hide_controls)


func _start_game():
	print("Got Start Signal")
	get_tree().change_scene_to_packed(main_game)
	AudioManager.pause_music(false)


func _controls_screen():
	print("Got Controls Signal")
	$CanvasLayer/controls.show()

func _hide_controls():
	print("Hiding Controls")
	$CanvasLayer/controls.hide()

func _leaderboard():
	print("Got Leaderboard Signal")
	pass
