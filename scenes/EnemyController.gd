extends Node2D
var Colony = preload("res://Colony.tscn")
var colony: Node2D
var startPosition = Vector2(150, 256)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = Colony.instantiate()
	colony.colonyColor = "blue"
	colony.position = startPosition
	colony.colonyDied.connect(_on_colony_die)
	add_child(colony)
	# Colony Specific Stats
	colony.set_stats(200, 1.0, 0, 2)  # imagine my surprise when GDScript doesnt support named arguments
	pass

func _on_colony_die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_parent().get_node('PlayerController')
	if player and player.get_node('Colony'):
		var direction = player.get_node('Colony').global_position - colony.global_position
		if abs(direction.x) < 400 && abs(direction.y) < 400:
			colony.move(direction)
		else:
			colony.move(startPosition - colony.global_position)
	pass
