extends TextureRect

var stat_name: StringName
var stat_desc: StringName
var purchased: bool
var base_cost: int

signal purchase(cost: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to button node
	$purchase_button.pressed.connect(self._purchase)
	self._update_name()
	self._update_cost()
	self._update_owned()
	self._update_tooltip()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create(statname="TEST", cost=100, desc="TODO"):
	self.stat_name = statname
	self.stat_desc = desc
	self.base_cost = cost
	self.purchased = false
	return self

func create_from_dict(statname, stat_dict):
	self.create(statname, stat_dict["Cost"], stat_dict["Description"])
	return self

func _update_name():  # FIXME: This doesn't center
	$purchase_button/update_label.text = center(black("[b]%s[/b]" % self.stat_name))
	
func _update_cost():
	$cost_disp.text = black("COST: %d" % self.base_cost)

func _update_owned():
	$owned_disp.text = black("OWNED: %d" % int(self.purchased))

func _update_tooltip():
	$purchase_button.tooltip_text = self.stat_desc

func _purchase():
	print("Purchased Upgrade")
	self.purchased = true
	purchase.emit(self.base_cost)
	print("Times Purchased %d" % int(self.purchased))
	self._update_cost()
	self._update_owned()

func black(txt: StringName) -> StringName:
	return "[center][color=black]%s[/color][/center]" % txt
	
func center(txt: StringName) -> StringName:
	return "[center]%s[/center]" % txt

func check_cost(food_val: int):
	if self.base_cost > food_val or self.purchased:
		$purchase_button.set_disabled(true)
	elif $purchase_button.is_disabled() and self.base_cost <= food_val:
		$purchase_button.set_disabled(false)
