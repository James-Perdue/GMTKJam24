extends Node2D
var Cell = preload("res://Cell.tscn")
var speed = 400
var velocity = Vector2.ZERO
var cellCount = 0
var spawnRadius = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(100):
		spawnCell()
	
	
	print(get_tree().current_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta

func move(direction: Vector2):
	velocity = direction.normalized() * speed

func spawnCell():
	var random_angle = randf() * 2 * PI  # Random angle in radians
	var new_point = Vector2(
		position.x + spawnRadius * cos(random_angle),
		position.y + spawnRadius * sin(random_angle)
	)
	
	var cellInstance = Cell.instantiate()
	get_parent().add_child.call_deferred(cellInstance)
	cellInstance.position = new_point
	cellInstance.colony = self
	cellCount+=1
	spawnRadius += 1
