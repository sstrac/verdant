extends Ability


class_name Hand

func _init():
	texture = preload("res://assets/textures/infrastructure/hand.png")
	
	
func perform(player):
	if player.closest_interactable:
		# Remove destroyable will be a different ability
		if player.closest_interactable.requires_hand:
			player.closest_interactable.interact(player)
