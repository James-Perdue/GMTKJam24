extends Node2D
var Food = preload("res://Food.tscn")
var EnemyController = preload("res://scenes/EnemyController.tscn")
var PlayerController = preload("res://PlayerController.tscn")
var tileMaps = {
	level1 = preload("res://levels/Lv1TileMap.tscn"),
	level2 = preload("res://levels/Lv2TileMap.tscn")
}

var enemies = [
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(150, 200),
		numCells = 1
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(2000, 200),
		numCells = 5
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 10,
		startPosition = Vector2(4000, 200),
		numCells = 2
	}
]

var player
var camera
func _ready() -> void:
	player = $PlayerController
	camera = $PlayerController/Colony/Camera2D
	initializeEnemies()
	$game_over.new_game.connect(self._start_new_game)
	player.gameOver.connect(self._on_player_controller_game_over)


func initializeEnemies() -> void:
	if(true):
		for enemy in enemies:
			print('enemy', enemy)
			var initializedEnemy = EnemyController.instantiate()
			initializedEnemy.colonySettings = enemy 
			add_child(initializedEnemy)
			initializedEnemy.add_to_group("enemy")
		
func _on_food_timer_timeout() -> void:
	var screenSize = get_viewport_rect().size
	if(camera):
		while(true):
			var x = randf_range(camera.global_position.x - screenSize.x * .3, camera.global_position.x + screenSize.x * .3)
			var y = randf_range(camera.global_position.y - screenSize.y * .3, camera.global_position.y + screenSize.y * .3)
			var checkPoint = PhysicsPointQueryParameters2D.new()
			checkPoint.position = Vector2(x,y)
			if(get_world_2d().direct_space_state.intersect_point(checkPoint).size() > 0):
				continue
			var foodInstance = Food.instantiate()
			add_child(foodInstance)
			foodInstance.position.x = x
			foodInstance.position.y = y
			foodInstance.add_to_group("foods")
			break

func _on_player_controller_game_over(won: bool) -> void:
	# Stop Food Spawning
	$FoodTimer.stop()
	# Remove all existing food
	for food in get_tree().get_nodes_in_group("foods"):
		food.queue_free()
	# Reset all enemies
	for enemy in get_tree().get_nodes_in_group("enemy"):
		print("Clearing enemy %s" % enemy)
		enemy.queue_free()
	# Create the game over screen
	$game_over.show_game_over(won)
	
func _start_new_game():
	print("Starting ...")
	# Clear the game over scene
	$game_over.hide()
	# Destroy and create Player Controller
	player = PlayerController.instantiate()
	self.add_child(player)
	player.gameOver.connect(self._on_player_controller_game_over)
	camera = player.get_camera()
	player.position = Vector2(617, 336)
	# Restart Food Timer
	$FoodTimer.start()
	# This forum post saved my life:
	# https://forum.godotengine.org/t/how-do-i-make-my-hud-track-with-a-moving-camera2d/12025
	initializeEnemies()
	
func changeLevel(levelNumber: int):
	var newLevel = tileMaps["level" + str(levelNumber)].instantiate()
	get_tree().root.get_child(0).replace_by(newLevel)
