extends Node2D
var colony: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = $Colony

func _process(_delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#print(input_vector)
	colony.move(input_vector)
