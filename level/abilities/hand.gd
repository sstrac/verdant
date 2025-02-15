extends Ability


class_name Hand

func _init():
	texture = preload("res://assets/textures/infrastructure/hand.png")
	
	
func perform(player) -> bool:
	if player.closest_interactable:
		if player.closest_interactable.requires_hand:
			player.closest_interactable.interact(player)
			return true
			
	return false
