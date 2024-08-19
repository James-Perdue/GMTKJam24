extends Area2D
var speed = 150  # Adjust the speed as needed
var target_position = Vector2()
var color : String
var lifeTime : int
var lifeRemaining : float

@onready var cellAnim = $CellAnimation;
func initialize(newSpeed : int, newColor : String, newLifeTime : int) -> void:
	if(newSpeed > 0):
		self.speed = newSpeed
	self.color = newColor
	self.lifeTime = newLifeTime
	
func _ready() -> void:
	cellAnim.modulate = Color(color)
	cellAnim.play("wiggle")
	randomize()
	target_position = get_parent().get_random_point_in_circle(get_parent().colonyRadius)
	move_to_target()
	lifeRemaining = lifeTime
	if(lifeTime > 0):
		await get_tree().create_timer(lifeTime, false).timeout
		killCell()

func killCell():
	# Be careful redefining _exit_tree as it can cause weird behavior when closing the game
	get_parent().cellDied.emit(self)
	queue_free()
	
func move_to_target():
	if(get_parent().colonyRadius == 0):
		return
	var direction = (target_position - position).normalized()
	position += direction * speed * get_process_delta_time()
	if position.distance_to(target_position) < speed * get_process_delta_time():
		target_position = get_parent().get_random_point_in_circle(get_parent().colonyRadius)

func _process(delta: float) -> void:
	if(lifeRemaining != 0):
		lifeRemaining -= delta
		cellAnim.modulate = Color(.5,.5,.5).lerp(Color(color), lifeRemaining / lifeTime)
	move_to_target()
