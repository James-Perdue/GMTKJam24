extends Node2D
var Colony = preload("res://Colony.tscn")
var colony: Node2D
var colonySettings = {
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(20, 256)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = Colony.instantiate()
	colony.colonyColor = colonySettings.colonyColor
	colony.position = colonySettings.startPosition
	colony.colonyDied.connect(_on_colony_die)
	add_child(colony)
	# Colony Specific Stats
	# Is there a need for this?
	colony.set_stats(colonySettings.speed, colonySettings.damageMultiplier, 0, colonySettings.cellDurability)  # imagine my surprise when GDScript doesnt support named arguments
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
			colony.move(colonySettings.startPosition - colony.global_position)
	pass
