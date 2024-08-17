extends TextureRect

@export var upgrade_option: PackedScene
@export var stat_dict: Dictionary


var upgrade_list = self._load_text_options("res://data/upgrades.json")
var food = 1000

signal food_status(food_val)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(upgrade_list)
	for stat_name in upgrade_list.keys():
		stat_dict[stat_name] = upgrade_option.instantiate().create_from_dict(stat_name, upgrade_list[stat_name])
		_add_to_grid(stat_dict[stat_name])
	$title_block/rich_text.text = "[p align=center][b][font_size=50]CHOOSE CELL UPGRADES[/font_size][/b][/p]"
	self._show_food()

func _show_food():
		$resource_display/rich_text.text = '[p align=center][font_size=30]Current Food: %d [img=30]res://icon.svg[/img][/font_size][/p]' % self.food

func _add_to_grid(new_upgrade):
	# Add new upgrades to the gridcontainer
	$upgrade_grid.add_child(new_upgrade)
	new_upgrade.size_flags_horizontal = 3
	new_upgrade.expand_mode = 5
	new_upgrade.purchase.connect(self._subtract_food)
	self.food_status.connect(new_upgrade.check_cost)

func _load_text_options(filename: StringName) -> Dictionary:
	var file = FileAccess.open(filename, FileAccess.READ)
	var content = file.get_as_text()
	print(content)
	var json = JSON.new()
	var error = json.parse(content)
	var upgr_opts
	if error == OK:
		upgr_opts = json.data
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
	return upgr_opts
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _subtract_food(amount):
	print("Reached %d " % amount)
	self.food -= amount
	self._show_food()
	food_status.emit(self.food)

# Return a dictionary representation of the upgrades for use by other systems
func to_dict():
	return stat_dict
