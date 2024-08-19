extends Node2D
var Colony = preload("res://Colony.tscn")
var colony: Node2D
var player
var active = true
var colonySettings = {
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(20, 256),
		numCells = 1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node('PlayerController')
	player.gameOver.connect(self._on_player_controller_game_over)
	colony = Colony.instantiate()
	colony.colonyColor = colonySettings.colonyColor
	colony.position = colonySettings.startPosition
	colony.initialCells = colonySettings.numCells
	colony.colonyDied.connect(_on_colony_die)
	# Colony Specific Stats
	# Is there a need for this?
	colony.set_stats(colonySettings.speed, colonySettings.damageMultiplier, 0, colonySettings.cellDurability)  # imagine my surprise when GDScript doesnt support named arguments
	add_child(colony)

func _on_colony_die():
	var food = round(colonySettings.numCells * colonySettings.cellDurability * .333)
	player.colony.food += food
	player.colony.foodChanged.emit(player.colony.food)
	queue_free()

func _on_player_controller_game_over(won: bool) -> void:
	active = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!active):
		return
	if player and player.get_node('Colony'):
		var direction = player.get_node('Colony').global_position - colony.global_position
		if abs(direction.x) < 400 && abs(direction.y) < 400:
			colony.move(direction)
		else:
			colony.move(colonySettings.startPosition - colony.global_position)
