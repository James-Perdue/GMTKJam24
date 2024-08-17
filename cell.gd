extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const moveDeadZone = 50

var target_position = Vector2.ZERO
var colony : Node2D

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if(colony):
		target_position = colony.position
		# Get the input direction and handle the movement/deceleration.
		if((target_position - position).length_squared() > moveDeadZone):
			var direction := (target_position - position).normalized()
			if direction:
				velocity = direction * SPEED
				
			move_and_slide()
