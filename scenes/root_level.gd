extends Node2D
var Food = preload("res://Food.tscn")
var EnemyController = preload("res://scenes/EnemyController.tscn")

var enemies = [
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(150, 1200)
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(2000, 200)
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 2,
		startPosition = Vector2(4000, 200)
	}
]

var player
var camera
func _ready() -> void:
	player = $PlayerController
	camera = $PlayerController/Colony/Camera2D
	initializeEnemies()

# Fix the control node size (containers really don't like being a child of Node2D)
func initializeEnemies() -> void:
	if(true):
		for enemy in enemies:
			print('enemy', enemy)
			var initializedEnemy = EnemyController.instantiate()
			initializedEnemy.colonySettings = enemy 
			add_child(initializedEnemy)
		
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


func _start_music():
	$background_music.stream = bkgnd_music
	$background_music.play()
	
