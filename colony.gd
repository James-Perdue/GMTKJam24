extends Node2D
var Cell = preload("res://Cell.tscn")
const perCellRadius = 15;

var speed = 400
var colonyRadius: int
var velocity = Vector2.ZERO
var cells = []
var food = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1):
		spawnCell()
	#print(get_tree().current_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	#print(position)

func move(direction: Vector2):
	velocity = direction.normalized() * speed

func splitCell():
	if(food >= 1):
		food -= 1
		spawnCell()
		
func spawnCell():
	var cellInstance = Cell.instantiate()
	cellInstance.color = "red"
	add_child(cellInstance)
	if(len(cells) > 0):
		cellInstance.position = cells[-1].position
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


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() != self && area.isFood == true:
		area.queue_free()
		food += 1
