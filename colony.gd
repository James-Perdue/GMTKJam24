extends CharacterBody2D

var SPEED = 200

@export var initialCells := 1
var Cell = preload("res://Cell.tscn")
var perCellRadius = 3;

var colonyRadius: int
var cells = []
var food = 0
var colonyColor : String = "red"

#Upgradeable Stats
var d_speed = 400
var d_damage_multiplier = 1.0
var d_cell_lifetime = 20
var d_cell_durability = 2
var d_food_efficiency = 1.0
var d_split_cost = 5

var speed : int = d_speed
var damageMultiplier : float = d_damage_multiplier
var cellLifeTime : int = d_cell_lifetime
var cellDurability : int = d_cell_durability
var food_efficiency : float = d_food_efficiency
var split_cost : int = d_split_cost

signal colonyUpdated()
signal cellDied(cell : Area2D)
signal foodChanged(newFood : int)
signal colonyDied()

func _init() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if(collision):
		var collider = collision.get_collider()
		if collider.has_meta("type"):
			var type = collider.get_meta("type")
			if type == "food":
				food += collider.get_nutrition() * self.food_efficiency
				collider.queue_free()
				foodChanged.emit(food)
				return
			if type == "colony":
				hitColony(collider)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_meta("type", "colony")
	self.cells = Array()
	var circleShapeInstance = CircleShape2D.new()
	self.get_node("Area2D/CollisionShape2D").shape = circleShapeInstance
	self.get_node("CollisionShape2D").shape = circleShapeInstance
	#self.set_stats()  # set stats using default, this wipes out any settings by controller, so commenting out
	
	print( "cell" + str(cellLifeTime))
	for i in range(initialCells):
		self.spawnCell(cellLifeTime)
	#print(get_tree().current_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass

func move(direction: Vector2):
	velocity = direction.normalized() * self.speed

func splitCell():
	if(food >= self.split_cost):
		food -= self.split_cost  # Cost is an adjustable stat now
		spawnCell(self.cellLifeTime)
		
func spawnCell(cell_life_time):
	print(cellLifeTime)
	var cellInstance = Cell.instantiate()
	cellInstance.color = colonyColor
	cellInstance.initialize(0, colonyColor, cell_life_time)
	add_child(cellInstance)
	if(len(cells) > 0):
		cellInstance.position = self.cells[-1].position
	self.cells.append(cellInstance)
	
	self.updateColony()
	
	
func updateColony():
	#print("update")
	self.colonyRadius = len(self.cells) * self.perCellRadius
	if self.get_node("Area2D/CollisionShape2D").shape is CircleShape2D:
		self.get_node("Area2D/CollisionShape2D").shape.radius = self.colonyRadius
	if self.get_node("CollisionShape2D").shape is CircleShape2D:
		self.get_node("CollisionShape2D").shape.radius = self.colonyRadius
	self.colonyUpdated.emit()
		
func get_random_point_in_circle(radius):
	var angle = randf_range(0, 2 * PI)
	var r = sqrt(randf_range(0, 1)) * radius
	var x = r * cos(angle)
	var y = r * sin(angle)
	return Vector2(x, y)

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.has_meta("type"):
		#var type = area.get_meta("type")
		#if type == "food":
			#food += area.get_nutrition() * self.food_efficiency
			#area.queue_free()
			#foodChanged.emit(food)
			#return
		#if type == "colony":
			#hitColony(area.get_parent())

func hitColony(colony):
	var totalDamage = len(cells) * self.damageMultiplier
	var cellsKilled = clamp(floor(totalDamage / colony.cellDurability), 0, len(colony.cells))
	var potentialCells = range(0, cellsKilled)
	for i in potentialCells:
		colony.cells[i].killCell()
	#print(cellsKilled)

func _on_cell_died(cell: Area2D) -> void:
	AudioManager.play_sound("Squelch", 1)
	cells.erase(cell)
	updateColony()
	if(len(cells) <= 0):
		colonyDied.emit()
		queue_free()

func _updateStats(new_food_total: int, new_stats: Dictionary):
	if(food != new_food_total):
		self.food = new_food_total
		foodChanged.emit()
	# Scale stats based on number of owned upgrades
	print(new_stats)
	var new_speed = d_speed + new_stats["Speed"] * 200
	var new_dam = d_damage_multiplier + new_stats["Surface Antigens"] * 0.2
	var new_lifetime = d_cell_lifetime + new_stats["Lifespan"] * 5
	var new_durability = d_cell_durability + new_stats["Toughness"] * 1
	var new_fe = d_food_efficiency + new_stats["Food Efficiency"] * 1.5
	var new_sc = max(1, d_split_cost - new_stats["Mitosis Cost"])  # Don't want negative split cost
	self.set_stats(new_speed, new_dam	, new_lifetime, new_durability, new_fe, new_sc)

# Nice setter for doing enemy stat blocks and stuff. Uses default values if not explicit
# Imagine my surprise when calling parameters by names isn't a thing in GDScript
func set_stats(n_speed=d_speed, n_damage_multiplier=d_damage_multiplier, n_cell_lifetime=d_cell_lifetime,
			   n_cell_durability=d_cell_durability, n_fe=d_food_efficiency, n_sc=d_split_cost):
	#print("SetStats")
	self.speed = n_speed
	self.damageMultiplier = n_damage_multiplier
	self.cellLifeTime = n_cell_lifetime
	self.cellDurability = n_cell_durability
	self.food_efficiency = n_fe
	self.split_cost = n_sc
