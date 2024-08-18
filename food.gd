extends Area2D

var isFood = true
var nutrition: int
const MINFOOD: int = 3
const MAXFOOD: int = 12 
const FOOD_TO_SCALE = 5.0

func _ready() -> void:
	self.set_meta("type", "food")
	self.nutrition = randi_range(MINFOOD, MAXFOOD)
	self.scale.x = self.nutrition / FOOD_TO_SCALE
	self.scale.y = self.nutrition / FOOD_TO_SCALE

func get_nutrition() -> int:
	return self.nutrition
