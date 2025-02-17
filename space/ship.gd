extends StaticBody2D


signal entered_after_revival


func disable_collision():
	set_collision_layer_value(2, false)


func enable_collision():
	set_collision_layer_value(2, true)


func _on_area_2d_area_entered(area: Area2D) -> void:
	var player = area.get_parent()
	if World.revived and not player.outro_cutscene:
		reparent(player)
		entered_after_revival.emit()
