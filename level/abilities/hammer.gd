extends Ability


class_name Hammer

func _init():
	texture = preload("res://assets/textures/infrastructure/building.png")
	
	
func perform(player):
	if player.closest_interactable:
		if player.closest_interactable.destroyable:
			player.closest_interactable.interact(player)
