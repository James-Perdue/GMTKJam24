extends Node2D
var Cell = preload("res://Cell.tscn")
const perCellRadius = 15;

var speed = 400
var colonyRadius: int
var velocity = Vector2.ZERO
var cells = []
var food = 0
var cellLifeTime = 20

signal cellDied(cell : Area2D)
signal colonyDied()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_meta("type", "colony")
	$Camera2D/hud_cont/hud.set_food(food)
	for i in range(1):
		spawnCell()
	#print(get_tree().current_scene)
	$Camera2D/hud_cont/hud.update_count(len(cells))
	$Camera2D/hud_cont/hud.upgraded.connect(self._apply_upgrades)
	
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
	cellInstance.initialize(0, "red", cellLifeTime)
	add_child(cellInstance)
	if(len(cells) > 0):
		cellInstance.position = cells[-1].position
	cells.append(cellInstance)
	
	updateColony()
	$Camera2D/hud_cont/hud.update_count(len(cells))
	$Camera2D/hud_cont/hud.set_food(food)
	
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
	if area.has_meta("type"):
		var type = area.get_meta("type")
		if type == "food":
			area.queue_free()
			food += 1
			$Camera2D/hud_cont/hud.set_food(food)
		if type == "colony":
			pass

func _on_cell_died(cell: Area2D) -> void:
	cells.erase(cell)
	updateColony()
	if(len(cells) <= 0):
		colonyDied.emit()
		queue_free()

func _apply_upgrades(new_food_total: int):
	self.food = new_food_total
