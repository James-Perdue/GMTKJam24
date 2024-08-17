extends Node2D
var colony: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = $Colony
	colony.colonyColor = "blue"
	#add_child(colony)
	colony.position = Vector2(150, 256)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_parent().get_node('PlayerController/Colony')
	var direction = player.global_position - colony.global_position
	if abs(direction.x) < 400 && abs(direction.y) < 400:
		colony.move(direction)
