extends Node2D
var colony: Node2D

signal gameOver(won : bool)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = $Colony

func _process(_delta: float) -> void:
	var viewport = get_viewport()
	viewport.canvas_transform.origin = -$Colony/Camera2D.global_position
	
	if(Input.is_action_just_pressed("action")):
		colony.splitCell()
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#print(input_vector)
	colony.move(input_vector)


func _on_colony_colony_died() -> void:
	gameOver.emit(false)
	queue_free()
