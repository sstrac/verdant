extends Ability


class_name Watering

func _init():
	texture = preload("res://assets/textures/infrastructure/watering_can.png")
	
	
func perform(player):
	if player.closest_interactable:
		if player.closest_interactable.waterable:
			player.closest_interactable.interact()
