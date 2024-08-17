extends Node2D
var Food = preload("res://Food.tscn")

var player
var enemy
var camera
func _ready() -> void:
	player = $PlayerController
	enemy = $EnemyController
	camera = $PlayerController/Colony/Camera2D

func _on_food_timer_timeout() -> void:
	
	var screenSize = get_viewport_rect().size
	var x = randf_range(camera.global_position.x - screenSize.x * .5, camera.global_position.x + screenSize.x * .5)
	var y = randf_range(camera.global_position.y - screenSize.y * .5, camera.global_position.y + screenSize.y * .5)
	
	var foodInstance = Food.instantiate()
	add_child(foodInstance)
	
	print(foodInstance.name)
	foodInstance.position.x = x
	foodInstance.position.y = y
