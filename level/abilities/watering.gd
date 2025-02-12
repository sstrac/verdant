extends Ability


class_name Watering

func _init():
	texture = preload("res://assets/textures/watering_can.png")
	
	
func perform(player):
	if player.closest_revivable:
		if not player.closest_revivable.revived:
			player.closest_revivable.revive()
