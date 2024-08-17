extends Area2D

var speed = 100  # Adjust the speed as needed
var radius = 200  # Radius of the circle
var target_position = Vector2()

var colony : Node2D
var color : String

@onready var cellAnim = $CellAnimation;

func _ready() -> void:
	cellAnim.modulate = Color(color)
	cellAnim.play("wiggle")
	randomize()
	target_position = get_parent().get_random_point_in_circle(radius)
	move_to_target()
	
func move_to_target():
	var direction = (target_position - position).normalized()
	position += direction * speed * get_process_delta_time()
	if position.distance_to(target_position) < speed * get_process_delta_time():
		target_position = get_parent().get_random_point_in_circle(radius)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	move_to_target()
