extends Node2D
var colony: Node2D

signal gameOver(won : bool)
var hud: HeadsUp
signal mute(is_muted: bool)
signal vol_change(new_volume: float)
var spawning = false
var heldSplitTimer: Timer

var keyHeld = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colony = $Colony
	hud = $Colony/CanvasLayer/hud_cont/hud
	hud.set_food(colony.food)
	hud.update_count(len(colony.cells))
	hud.upgraded.connect(colony._updateStats)
	heldSplitTimer = Timer.new()
	heldSplitTimer.set_wait_time(.25)
	heldSplitTimer.set_one_shot(false)
	heldSplitTimer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(heldSplitTimer)

	hud.mutated.connect(colony._update_mutations)
	
func _on_Timer_timeout():
	if keyHeld:
		colony.splitCell()
	
func _process(_delta: float) -> void:
	var viewport = get_viewport()
	viewport.canvas_transform.origin = -$Colony/Camera2D.global_position
	if(Input.is_action_pressed("action") and not keyHeld):
		keyHeld = true
		colony.splitCell()
		heldSplitTimer.start()
	if(not Input.is_action_pressed("action") and keyHeld):
		keyHeld = false
		heldSplitTimer.stop()
	
	if(Input.is_action_just_pressed("attack")):
		colony.flagellate()
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#print(input_vector)
	colony.move(input_vector)


# Return camera node - used for resetting food spawning after newgame
func get_camera():
	return $Colony/Camera2D

func _on_colony_colony_died() -> void:
	gameOver.emit(false)
	queue_free()

func _on_colony_colony_updated() -> void:
	if(colony):
		$Colony/CanvasLayer/hud_cont/hud.update_count(len(colony.cells))
	if(colony):
		$Colony/CanvasLayer/hud_cont/hud.set_food(colony.food)


func _on_colony_food_changed(newFood: int) -> void:
	$Colony/CanvasLayer/hud_cont/hud.set_food(newFood)
