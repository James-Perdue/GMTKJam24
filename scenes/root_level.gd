extends Node2D
var Food = preload("res://Food.tscn")
var EnemyController = preload("res://scenes/EnemyController.tscn")
var PlayerController = preload("res://PlayerController.tscn")
var tileMaps = {
	level1 = preload("res://levels/Lv1TileMap.tscn"),
	level2 = preload("res://levels/Lv2TileMap.tscn"),
	level3 = preload("res://levels/Lv3TileMap.tscn")
}

var enemiesLvl1Area1 = [
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
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(4343, -1269),
		numCells = 30
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(3601, -1273),
		numCells = 20
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(2813, -1273),
		numCells = 25
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 10,
		startPosition = Vector2(2153, -1273),
		numCells = 15
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(1817, -1264),
		numCells = 35
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(1309, -1260),
		numCells = 10
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(698, -1398),
		numCells = 30
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(34, -1290),
		numCells = 30
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(-414, -1326),
		numCells = 5
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 10,
		startPosition = Vector2(-1726, -1349),
		numCells = 45
	},
	{
		colonyColor = 'cyan',
		cellDurability = 10,
		speed = 600,
		damageMultiplier = 15,
		startPosition = Vector2(-3355, -1292),
		numCells = 2
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(-3347, -3322),
		numCells = 100
	},
	{
		colonyColor = 'green',
		cellDurability = 3,
		speed = 300,
		damageMultiplier = 1,
		startPosition = Vector2(-2300, -3344),
		numCells = 100
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 10,
		startPosition = Vector2(-1083, -3301),
		numCells = 75
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(-36, -3322),
		numCells = 150
	},
	{
		colonyColor = 'cyan',
		cellDurability = 10,
		speed = 700,
		damageMultiplier = 15,
		startPosition = Vector2(2934, -3333),
		numCells = 30
	},
	{
		colonyColor = 'cyan',
		cellDurability = 10,
		speed = 600,
		damageMultiplier = 15,
		startPosition = Vector2(3766, -3333),
		numCells = 40
	},
	{
		colonyColor = 'pink',
		cellDurability = 50,
		speed = 75,
		damageMultiplier = 50,
		startPosition = Vector2(5686, -3253),
		numCells = 1
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 10,
		startPosition = Vector2(6931, -4214),
		numCells = 100
	}
	
]
var enemiesLvl2Area1 = [
	{
		colonyColor = 'brown',
		cellDurability = 10,
		speed = 200,
		damageMultiplier = 15,
		startPosition = Vector2(1011, 9),
		numCells = 30
	},
	{
		colonyColor = 'pink',
		cellDurability = 50,
		speed = 75,
		damageMultiplier = 50,
		startPosition = Vector2(1281, 752),
		numCells = 15
	},
	{
		colonyColor = 'cyan',
		cellDurability = 10,
		speed = 700,
		damageMultiplier = 15,
		startPosition = Vector2(2324, 1112),
		numCells = 70
	},
	{
		colonyColor = 'blue',
		cellDurability = 5,
		speed = 200,
		damageMultiplier = 2,
		startPosition = Vector2(3500, 650),
		numCells = 100
	},
	{
		colonyColor = 'black',
		cellDurability = 5,
		speed = 100,
		damageMultiplier = 15,
		startPosition = Vector2(4538, -1542),
		numCells = 200
	}
]

var enemiesLvl3Area1 = [
	{
		colonyColor = 'white',
		cellDurability = 25,
		speed = 150,
		damageMultiplier = 15,
		startPosition = Vector2(2133, 1172),
		numCells = 200
	}
]

var player
var camera
var game_over
func _ready() -> void:
	player = $PlayerController
	camera = $PlayerController/Colony/Camera2D
	initializeEnemies()
	game_over = $game_over_canvas/game_over
	game_over.new_game.connect(self._start_new_game)
	player.gameOver.connect(self._on_player_controller_game_over)


func initializeEnemies() -> void:
	if(true):
		for enemy in enemiesLvl1Area1:
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
	cleanUp()
	# Create the game over screen
	game_over.show_game_over(won)
	
func cleanUp():
	for food in get_tree().get_nodes_in_group("foods"):
		food.queue_free()
	# Reset all enemies
	for enemy in get_tree().get_nodes_in_group("enemy"):
		print("Clearing enemy %s" % enemy)
		enemy.queue_free()

func _start_new_game():
	print("Starting ...")
	# Clear the game over scene
	game_over.hide()
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
	
func change_level(levelNumber: int):
	var newLevel = tileMaps["level" + str(levelNumber)].instantiate()
	print("newLevel", newLevel)
	cleanUp()
	self.get_child(0).call_deferred("replace_by", newLevel)
	self.get_node('PlayerController').get_node('Colony').global_position = Vector2(617, 336)
	if(newLevel.name == "Lv2TileMap" and true):
		for enemy in enemiesLvl2Area1:
			print('enemy', enemy)
			var initializedEnemy = EnemyController.instantiate()
			initializedEnemy.colonySettings = enemy 
			add_child(initializedEnemy)
			initializedEnemy.add_to_group("enemy")
	if(newLevel.name == "Lv3TileMap" and true):
		for enemy in enemiesLvl3Area1:
			print('enemy', enemy)
			var initializedEnemy = EnemyController.instantiate()
			initializedEnemy.colonySettings = enemy 
			add_child(initializedEnemy)
			initializedEnemy.add_to_group("enemy")
