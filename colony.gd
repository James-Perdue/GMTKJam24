extends Node2D
var Cell = preload("res://Cell.tscn")
const perCellRadius = 2.5;

var speed = 400
var colonyRadius = 200
var velocity = Vector2.ZERO
var cells = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(100):
		spawnCell()
	#print(get_tree().current_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	#print(position)

func move(direction: Vector2):
	velocity = direction.normalized() * speed

func spawnCell():
	#var random_angle = randf() * 2 * PI  # Random angle in radians
	#var new_point = Vector2(
		#position.x + spawnRadius * cos(random_angle),
		#position.y + spawnRadius * sin(random_angle)
	#)
	
	var cellInstance = Cell.instantiate()
	add_child(cellInstance)
	#cellInstance.position = get_random_point_in_circle(radius)
	cellInstance.colony = self
	cellInstance.color = "red"
	cells.append(cellInstance)
	
	updateColony()
	
func updateColony():
	colonyRadius = len(cells) * perCellRadius
	if $Area2D/CollisionShape2D.shape is CircleShape2D:
		$Area2D/CollisionShape2D.shape.radius = colonyRadius
		
func get_random_point_in_circle(radius):
	var angle = randf_range(0, 2 * PI)
	var r = sqrt(randf_range(0, 1)) * radius
	var x = r * cos(angle)
	var y = r * sin(angle)
	return Vector2(x, y)
