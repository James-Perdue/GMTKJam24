extends TextureRect

var stat_name: StringName
var stat_desc: StringName
var purchased: int
var base_cost: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to button node
	$purchase_button.pressed.connect(self._purchase)
	self._update_name()
	self._update_cost()
	self._update_owned()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create(statname="TEST", cost=100, desc="TODO"):
	self.stat_name = statname
	self.stat_desc = desc
	self.base_cost = cost
	self.purchased = 0
	return self

func _update_name():
	$purchase_button/update_label.text = black("Upgrade Name: %s" % self.stat_name)
	
func _update_cost():
	$cost_disp.text = black("COST: %d" % self.base_cost)

func _update_owned():
	$owned_disp.text = black("OWNED: %d" % self.purchased)

func _purchase():
	print("Purchased Upgrade")
	self.purchased += 1
	print("Times Purchased %d" % self.purchased)
	self._update_cost()
	self._update_owned()
	
func black(txt: StringName) -> StringName:
	return "[color=black]%s[/color]" % txt
