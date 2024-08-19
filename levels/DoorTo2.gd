extends Area2D


func _on_area_entered(area: Area2D) -> void:
	print("area", area)
	if area.get_parent().has_meta("isPlayer"):
		print("isPlayer", get_tree().current_scene.name)
		get_tree().current_scene.change_level(2)
