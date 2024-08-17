extends TextureRect

@export var upgrade_option: PackedScene
@export var stat_dict: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stat_name
	for i in range(10):
		stat_name = "Temp_stat %d" % i
		stat_dict[stat_name] = upgrade_option.instantiate().create(stat_name, 100, "Fake")
		_add_to_grid(stat_dict[stat_name])
	$title_block/rich_text.text = "[p align=center][b][font_size=50]CHOOSE CELL UPGRADES[/font_size][/b][p]"
	$resource_display/rich_text.text = '[p align=center][font_size=30]Current Food: 100 [img=30]res://icon.svg[/img][/font_size][/p]'

func _add_to_grid(new_upgrade):
	# Add new upgrades to the gridcontainer
	$upgrade_grid.add_child(new_upgrade)
	new_upgrade.size_flags_horizontal = 3
	new_upgrade.expand_mode = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
