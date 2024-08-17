extends Node2D
var Colony = preload("res://Colony.tscn")
var colony: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = Colony.instantiate()
	colony.colonyColor = "blue"
	colony.position = Vector2(150, 256)
	add_child(colony)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_parent().get_node('PlayerController/Colony')
	var direction = player.global_position - colony.global_position
	if abs(direction.x) < 400 && abs(direction.y) < 400:
		colony.move(direction)
