extends Node2D
var Food = preload("res://Food.tscn")

var player
var camera
func _ready() -> void:
	player = $PlayerController
	camera = $PlayerController/Colony/Camera2D

# Fix the control node size (containers really don't like being a child of Node2D)

func _on_food_timer_timeout() -> void:
	var screenSize = get_viewport_rect().size
	if(camera):
		var x = randf_range(camera.global_position.x - screenSize.x * .3, camera.global_position.x + screenSize.x * .3)
		var y = randf_range(camera.global_position.y - screenSize.y * .3, camera.global_position.y + screenSize.y * .3)
		
		var foodInstance = Food.instantiate()
		add_child(foodInstance)
		foodInstance.position.x = x
		foodInstance.position.y = y


func _on_player_controller_game_over(won: bool) -> void:
	$FoodTimer.stop()
	$FoodTimer.queue_free() # Replace with function body.
