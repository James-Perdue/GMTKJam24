extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_meta("isPlayer"):
		print("isPlayer", get_tree().current_scene.name)
		get_tree().current_scene._on_player_controller_game_over(true)
