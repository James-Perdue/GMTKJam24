extends Node2D
var Colony = preload("res://Colony.tscn")
var colony: Node2D
var startPosition = Vector2(150, 256)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = Colony.instantiate()
	colony.colonyColor = "blue"
	colony.speed = 200
	colony.position = startPosition
	colony.cellLifeTime = 0
	add_child(colony)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_parent().get_node('PlayerController')
	if player:
		var direction = player.get_node('Colony').global_position - colony.global_position
		if abs(direction.x) < 400 && abs(direction.y) < 400:
			colony.move(direction)
		else:
			colony.move(startPosition - colony.global_position)
	print(colony.get_node("Area2D/CollisionShape2D").shape.radius)
	pass
