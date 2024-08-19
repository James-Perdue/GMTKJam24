class_name HeadsUp
extends Control

var upgrade_scene = preload("res://scenes/upgrade.tscn")
var upgrade_loaded
signal upgraded(new_food, upgrade_dict)

# Volume values and textures
var is_muted := false
var tex_unmuted = preload("res://art/volume.png")
var tex_muted = preload("res://art/muted.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.upgrade_loaded = upgrade_scene.instantiate()
	add_child(self.upgrade_loaded)
	self.upgrade_loaded.hide()
	self.upgrade_loaded.process_mode = PROCESS_MODE_ALWAYS
	$mutations/Button.pressed.connect(self._mutate)
	$upgrades/Button.pressed.connect(self._upgrade)
	$volume_control/Button.pressed.connect(self._toggle_mute)
	$volume_control/PanelContainer/HSlider.value_changed.connect(self._change_volume)
	self.upgrade_loaded.exit_scene.connect(self._close_screen)
	self.is_muted = AudioManager.is_muted  # sync muted status on creation
	self._update_mute_display()
	self._update_vol_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _mutate():
	print("Mutation Screen")

func _upgrade():
	print("Upgrade Screen")
	get_tree().paused = true
	self.upgrade_loaded.show()
	self.upgrade_loaded._show_food()
	
func _close_screen(new_food):
	print("Exiting Screen")
	self.upgrade_loaded.hide()
	get_tree().paused = false
	self.set_food(new_food)
	self.upgraded.emit(new_food, self.upgrade_loaded.to_dict())  # Signal going back up to colony

func set_food(new_food: int):
	self.upgrade_loaded.food = new_food
	self.upgrade_loaded.food_status.emit(new_food)  # Signal syncing to upgrade screen
	$food_count/RichTextLabel.text = "[color=black]FOOD: %d[/color]" % self.upgrade_loaded.food

func update_count(new_count: int):
	$cell_count/RichTextLabel.text = "[color=black]CELLS: %d[/color]" % new_count

func _update_mute_display():
	if self.is_muted:
		$volume_control/Button.texture_normal = tex_muted
	else:
		$volume_control/Button.texture_normal = tex_unmuted


func _update_vol_display():
	# Update for starting after a new game
	print("Syncing volume setting %s" % db_to_linear(AudioManager.get_master_volume()))
	$volume_control/PanelContainer/HSlider.set_value_no_signal(db_to_linear(AudioManager.get_master_volume()))

func _toggle_mute():
	print("Toggled Function")
	# Toggle muting
	self.is_muted = not self.is_muted
	self._update_mute_display()
	AudioManager.mute(self.is_muted)

func _change_volume(new_vol_lin: float):
	# Change Volume Value (returns value in dB)
	var new_vol_db = linear_to_db(new_vol_lin)
	AudioManager.set_master_volume(new_vol_db)
