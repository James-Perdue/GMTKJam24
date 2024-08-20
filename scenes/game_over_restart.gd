extends TextureRect
var won = false

signal new_game()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	$upgrade_grid/leaderboard/Button.pressed.connect(self._show_leaderboard)
	$upgrade_grid/controls/Button.pressed.connect(self._show_controls)
	$upgrade_grid/new_game/Button.pressed.connect(self._start_new_game)
	$CanvasLayer/controls.exit_c.connect(self._hide_controls)
	$exit_cont/exit_button.pressed.connect(self._quit_game)
	$CanvasLayer/controls.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_game_over(victory: bool):
	get_tree().paused = true
	#var vp_size = get_viewport().size
	#print(vp_size)
	#self.size = vp_size
	if(victory):
		won = true
		$title_block/rich_text.text = "[center][font_size=94]Victory![/font_size][/center]"
		$resource_display/rich_text.text = "[center][font_size=46]On to the next host... Click [New Game] to try again. [/font_size][/center]"
	else:
		won = false
	$CanvasLayer/controls.hide()
	self.show()

func _show_leaderboard():
	print("Go to leaderboard screen")

func _show_controls():
	print("Go to controls screen")
	$CanvasLayer/controls.show()

func _hide_controls():
	print("Hiding Controls")
	$CanvasLayer/controls.hide()

func _start_new_game():
	if(!won):
		print("Resetting Game")
		get_tree().paused = false
		self.new_game.emit()
		return
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _quit_game():
	var splashScreen = load("res://scenes/splash_screen.tscn")
	print("Quitting Game")
	if(splashScreen):
		get_tree().paused = false
		get_tree().change_scene_to_packed(splashScreen)
		AudioManager.pause_music(true)
	#get_tree().quit()
