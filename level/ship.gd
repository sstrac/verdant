extends StaticBody2D


func disable_collision():
	set_collision_layer_value(2, false)


func enable_collision():
	set_collision_layer_value(2, true)
