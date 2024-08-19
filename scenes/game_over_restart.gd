extends TextureRect

signal new_game()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	$upgrade_grid/leaderboard/Button.pressed.connect(self._show_leaderboard)
	$upgrade_grid/controls/Button.pressed.connect(self._show_controls)
	$upgrade_grid/new_game/Button.pressed.connect(self._start_new_game)
	$exit_cont/exit_button.pressed.connect(self._quit_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_game_over(victory: bool):
	get_tree().paused = true
	#var vp_size = get_viewport().size
	#print(vp_size)
	#self.size = vp_size
	self.show()

func _show_leaderboard():
	print("Go to leaderboard screen")

func _show_controls():
	print("Go to controls screen")

func _start_new_game():
	print("Resetting Game")
	get_tree().paused = false
	self.new_game.emit()
	
func _quit_game():
	print("Quitting Game")
	get_tree().quit()
