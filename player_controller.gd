extends Node2D
var colony: Node2D

signal gameOver(won : bool)
var hud: HeadsUp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = $Colony
	hud = $Colony/Camera2D/hud_cont/hud
	$Colony/Camera2D/hud_cont/hud.set_food(colony.food)
	$Colony/Camera2D/hud_cont/hud.update_count(len(colony.cells))
	$Colony/Camera2D/hud_cont/hud.upgraded.connect(colony._updateStats)
	self._set_hud_location()

func _set_hud_location():
		# Fix scale - for some reason need to do 4x scale
	var vp_size = get_viewport_rect()
	var cam_position = -$Colony/Camera2D.global_position
	$Colony/Camera2D/hud_cont.position = cam_position
	# Get top corner position = global_position - size * 4
	print(-$Colony/Camera2D.global_position)
	$Colony/Camera2D/hud_cont.size = vp_size.size
	$Colony/Camera2D/hud_cont.scale = Vector2(4, 4)

func _process(_delta: float) -> void:
	var viewport = get_viewport()
	viewport.canvas_transform.origin = -$Colony/Camera2D.global_position
	
	if(Input.is_action_just_pressed("action")):
		colony.splitCell()
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#print(input_vector)
	colony.move(input_vector)


func _on_colony_colony_died() -> void:
	gameOver.emit(false)
	queue_free()

func _on_colony_colony_updated() -> void:
	if(colony):
		$Colony/Camera2D/hud_cont/hud.update_count(len(colony.cells))
	if(colony):
		$Colony/Camera2D/hud_cont/hud.set_food(colony.food)


func _on_colony_food_changed(newFood: int) -> void:
	$Colony/Camera2D/hud_cont/hud.set_food(newFood)
