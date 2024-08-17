extends Area2D
var speed = 100  # Adjust the speed as needed
var target_position = Vector2()
var color : String

@onready var cellAnim = $CellAnimation;

func _ready() -> void:
	cellAnim.modulate = Color(color)
	cellAnim.play("wiggle")
	print(color)
	randomize()
	target_position = get_parent().get_random_point_in_circle(get_parent().colonyRadius)
	move_to_target()
	
func move_to_target():
	var direction = (target_position - position).normalized()
	position += direction * speed * get_process_delta_time()
	if position.distance_to(target_position) < speed * get_process_delta_time():
		target_position = get_parent().get_random_point_in_circle(get_parent().colonyRadius)

func _process(_delta: float) -> void:
	move_to_target()
