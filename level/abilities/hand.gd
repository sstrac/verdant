extends Ability


class_name Hand

func _init():
	texture = preload("res://assets/textures/infrastructure/hand.png")
	
	
func perform(player):
	if player.closest_interactable:
		# Remove destroyable will be a different ability
		if player.closest_interactable.obtainable or player.closest_interactable.destroyable:
			player.closest_interactable.interact()
			player.available_abilities.append(Watering.new())
