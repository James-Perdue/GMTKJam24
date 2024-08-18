extends Node2D
@export var initialCells := 1

var Cell = preload("res://Cell.tscn")
var perCellRadius = 15;

var colonyRadius: int
var velocity = Vector2.ZERO
var cells = []
var food = 0
var colonyColor : String = "red"

#Upgradeable Stats
var speed = 400
var damageMultiplier = 1
var cellLifeTime := 20
var cellDurability := 2

signal colonyUpdated()
signal cellDied(cell : Area2D)
signal foodChanged(newFood : int)
signal colonyDied()

func _init() -> void:
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.set_meta("type", "colony")
	self.cells = Array()
	var circleShapeInstance = CircleShape2D.new()
	self.get_node("Area2D/CollisionShape2D").shape = circleShapeInstance
	for i in range(initialCells):
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
	cellInstance.color = colonyColor
	cellInstance.initialize(0, colonyColor, cellLifeTime)
	add_child(cellInstance)
	if(len(cells) > 0):
		cellInstance.position = self.cells[-1].position
	self.cells.append(cellInstance)
	
	self.updateColony()
	
	
func updateColony():
	print("update")
	self.colonyRadius = len(self.cells) * self.perCellRadius
	if self.get_node("Area2D/CollisionShape2D").shape is CircleShape2D:
		self.get_node("Area2D/CollisionShape2D").shape.radius = self.colonyRadius
	self.colonyUpdated.emit()
		
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
			foodChanged.emit(food)
			return
		if type == "colony":
			hitColony(area.get_parent())
	
func hitColony(colony):
	var totalDamage = len(cells) * damageMultiplier
	var cellsKilled = clamp(floor(totalDamage / colony.cellDurability), 0, len(colony.cells))
	var potentialCells = range(0, cellsKilled)
	for i in potentialCells:
		colony.cells[i].killCell()
	print(cellsKilled)

func _on_cell_died(cell: Area2D) -> void:
	cells.erase(cell)
	updateColony()
	if(len(cells) <= 0):
		colonyDied.emit()
		queue_free()

func _updateStats(new_food_total: int):
	if(food != new_food_total):
		self.food = new_food_total
		foodChanged.emit()
	
