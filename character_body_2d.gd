extends CharacterBody2D


func _physics_process(delta: float) -> void:
	move_and_slide()

func move(newPosition: Vector2) -> void:
	position += newPosition
	self.get_parent().position = position
