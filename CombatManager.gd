extends Node2D
var fighting = false

func startFight(colonyA, colonyB):
	if not fighting:
		AudioManager.play_sound("Fight", .5)
		fighting = true
		processFight(colonyA, colonyB)
		await get_tree().create_timer(.5, false).timeout
		fighting = false

func processFight(colonyA, colonyB):
	var colonyADamage = colonyA.damageMultiplier
	var colonyANumCells = len(colonyA.cells)
	var colonyBDamage = colonyB.damageMultiplier
	var colonyBNumCells = len(colonyB.cells)
	
	hitColony(colonyA, colonyBDamage, colonyBNumCells)
	hitColony(colonyB, colonyADamage, colonyANumCells)
		
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func hitColony(colony, numCells, damageMultiplier):
	var totalDamage = numCells * damageMultiplier
	var cellsKilled = clamp(floor(totalDamage / colony.cellDurability), 0, len(colony.cells))
	var potentialCells = range(0, cellsKilled)
	for i in potentialCells:
		if(len(colony.cells) <= i):
			break
		colony.cells[i].killCell()
